require "live_quiz/pub_nub"

class Participant < ActiveRecord::Base
  belongs_to :session
  
  validates :email, email: true
  validates :email, uniqueness: { scope: :session, message: "cannot be used more than one time" }

  validates :email, :authorization_key, :authorization_password, presence: true

  before_validation :generate_authorization_key, :generate_authorization_password, on: :create
  after_commit :grant_access_to_session_channels, on: :create
  after_commit :revoke_access_to_session_channels, on: :destroy

  # Return if the question have been answered correctly or not
  def answer_question(question, answer)
    question.correct_answer.id == answer.id
    ## TODO Save Answered question
  end

  private

  def generate_authorization_key
		 begin
    		self.authorization_key = SecureRandom.hex(8)
  	 end while self.class.exists?(authorization_key: authorization_key)
	end

	def generate_authorization_password
		 begin
    		self.authorization_password = SecureRandom.hex(8)
  	 end while self.class.exists?(authorization_password: authorization_password)
	end

  def grant_access_to_session_channels
    LiveQuiz::PubNub.client.grant(channel: self.session.server_channel, auth_key: self.authorization_key ,  read: true, write: false){|envelope| puts envelope.payload}
    LiveQuiz::PubNub.client.grant(channel: self.session.client_channel, auth_key: self.authorization_key ,  read: false, write: true){|envelope| puts envelope.payload}
    LiveQuiz::PubNub.client.grant(:channel => self.session.chat_channel, presence: self.session.chat_channel, auth_key: self.authorization_key){|envelope| puts envelope.payload}
  end

  def revoke_access_to_session_channels
    LiveQuiz::PubNub.client.revoke(:channel => self.session.server_channel, auth_key: self.authorization_key){|envelope|}
    LiveQuiz::PubNub.client.revoke(:channel => self.session.client_channel, auth_key: self.authorization_key){|envelope|} 
    LiveQuiz::PubNub.client.revoke(:channel => self.session.chat_channel, presence: self.session.chat_channel, auth_key: self.authorization_key){|envelope|}
  end

end