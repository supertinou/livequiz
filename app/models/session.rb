require "live_quiz/pub_nub"

class Session < ActiveRecord::Base
  belongs_to :quiz
  before_validation :generate_access_key, on: :create
  validates :quiz, presence: true

  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants, reject_if: :all_blank, allow_destroy: true

  validate :participants do 
   	errors.add(:participants, "should not be empty") if self.participants.length <= 0
  end

  after_commit :set_forbidden_access_to_session_channels, on: [:create,:destroy]
  after_commit :allow_full_rights_to_channels_to_quiz, on: [:create]

  def to_param
     access_key
  end

  #  Channel used to send server data to clients
  def server_channel
      "#{access_key}-server"
  end

  #  Channel used to send client data to server
  def client_channel
      "#{access_key}-client"
  end

  def chat_channel
      "#{access_key}-chat"
  end

  def current_question
    current_question_index ? self.quiz.questions.rank(:row_order)[current_question_index] : nil
  end

  # Start the quiz session
  def start!(config = {})
    config[:mode] ||= :scheduled

    self.current_question_index = 0
    self.starting_date = DateTime.now()
    subscribe_to_client_events()
    send_current_question()
    schedule_switch_to_next_question!(30) if config[:mode] == :scheduled
    save()
  end

  # schedule switch to a next question every X secondes until the end
  def schedule_switch_to_next_question!(secondes)
      Rufus::Scheduler.singleton.in "#{secondes}s" do
        ActiveRecord::Base.connection_pool.with_connection do
          if switch_to_next_question!
            schedule_switch_to_next_question!(secondes)
          else
            finish()
          end
        end
      end
  end

  def send_current_question
    send_event_with_data('question', {question: current_question.format(:title_with_answers)} )
  end

  def send_results
    send_event_with_data('results', {results: results} )
  end

  def send_event_with_data(event, data)
      cb = lambda { |envelope| puts envelope.message }
      message = {event: event, data: data}
      LiveQuiz::PubNub.client.publish(message: message, channel: self.server_channel, auth_key: auth_key, callback: cb)
  end

  def started?
    starting_date.present?
  end

  def auth_key
    quiz.access_key
  end

  # Switch to next question
  # Return false if it can't switch because it's the final question
  def switch_to_next_question!

    raise "Quiz has to be started to switch the question" if !started?

    next_question_index = self.current_question_index + 1
    next_question_exist = self.quiz.questions.rank(:row_order)[next_question_index]
    succeeded_to_switch = if !next_question_exist.nil?
                          self.current_question_index = next_question_index
                          send_current_question()
                          save()
                        else
                          false
                        end
    return succeeded_to_switch                  
  end

  # End the quiz session and send the results
  def finish
    send_results()
  end

  def subscribe_to_client_events
    LiveQuiz::PubNub.client.subscribe(
      channel:  client_channel,
      auth_key: auth_key,
      callback: handle_client_events
    )
  end

  # called each time there is an event sent in the client channel
  def handle_client_events
    lambda do |envelope|
      m = envelope.message
      case m['event']
      when 'answer'
        handle_question_answer(m['auth_key'], m['data']['answer_id'])
      end
    end
  end

  def handle_question_answer(auth_key, answer_id)
    
    ActiveRecord::Base.connection_pool.with_connection do
      
      participant = self.participants.where(authorization_key: auth_key).take
      
      answer = Answer.find(answer_id)
      allowed_to_answer_question = ( answer.question.id == current_question.id )

      if !participant.have_already_answered_the_question?(answer.question) 

        if allowed_to_answer_question
        
          answered_correctly = participant.answer_question(current_question, answer)
        
          send_event_with_data('answered', { uuid: participant.authorization_key, 
                                       name: participant.name, 
                                       timestamp: Time.now.to_i,
                                       correct: answered_correctly
                                      })
        else

          send_event_with_data('answered_over_time', { uuid: participant.authorization_key, 
                                                       name: participant.name, 
                                                     })

        end

      end
    end

  end

  def results

    participants.order('points DESC').collect do |participant| 
      {
          points: participant.points,
          uuid: participant.authorization_key, 
          name: participant.name,
          correct_answers_number: participant.number_of_correct_answers, 
          wrong_answers_number: participant.number_of_wrong_answers 
      }
    end

  end

private

  def generate_access_key
		begin
    		self.access_key= SecureRandom.hex(8)
  		end while self.class.exists?(access_key: access_key)
  end

  def set_forbidden_access_to_session_channels
      [server_channel,client_channel,chat_channel].each do |chan| 
        LiveQuiz::PubNub.client.grant(http_sync: true, channel: chan, read: false, write: false){|envelope|}
      end
  end

  def allow_full_rights_to_channels_to_quiz
      [server_channel,client_channel].each do |chan|
          LiveQuiz::PubNub.client.grant(http_sync: true, channel: chan, presence: chan, auth_key: auth_key, read: true, write: true){|envelope| puts envelope.payload}
      end
  end

end
