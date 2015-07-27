require 'rails_helper'

RSpec.describe Session,  :type => :model, :vcr => {:cassette_name => 'models/session'} do

  let(:quiz) { FactoryGirl.create :quiz_with_questions_and_answers }
  let(:quiz_session) { FactoryGirl.create :session, quiz: quiz }
  let(:ordered_questions) {quiz.questions.rank(:row_order)}

  describe '#start!' do
  	before { quiz_session.start! }

  	it 'update attributes accordingly' do
  		expect(quiz_session.starting_date).not_to eq(nil)
  		expect(quiz_session.current_question).to eq(ordered_questions[0]) 
  		expect(quiz_session.started?).to eq(true) 
  	end

  end

  describe '#started?' do

  	context 'quiz is started' do 
  		before { quiz_session.start! }
  		it 'should be started' do 
  			expect(quiz_session.started?).to eq true
  		end
  	end 

  	context 'quiz is not started' do
  		it 'should not be started' do 
  			expect(quiz_session.started?).to eq false
  		end
  	end 

  end

  describe '#switch_to_next_question!' do

    before { quiz_session.start! }

    it "succeed to switch question until the end" do

      expect(quiz_session.current_question_index).to eq(0)

      expect(quiz_session.switch_to_next_question!).to eq(true)
      expect(quiz_session.current_question_index).to eq(1)

      expect(quiz_session.switch_to_next_question!).to eq(true)
      expect(quiz_session.current_question_index).to eq(2)

      expect(quiz_session.switch_to_next_question!).to eq(true)
      expect(quiz_session.current_question_index).to eq(3)

      expect(quiz_session.switch_to_next_question!).to eq(false)
      expect(quiz_session.current_question_index).to eq(3)

    end

  end

  describe '#results' do

  	subject{ quiz_session.results }

  	let(:participant1) { quiz_session.participants[0] }
  	let(:participant2) { quiz_session.participants[1] }
  	let(:participant3) { quiz_session.participants[2] }
  	let(:participant4) { quiz_session.participants[3] }


  	before do
  		quiz_session.start!(mode: :manual)
  		participant2.answer_question(quiz_session.current_question, quiz_session.current_question.correct_answer)
  		participant1.answer_question(quiz_session.current_question, quiz_session.current_question.correct_answer)
  		quiz_session.switch_to_next_question!
  		participant2.answer_question(quiz_session.current_question, quiz_session.current_question.correct_answer)
  		participant1.answer_question(quiz_session.current_question, quiz_session.current_question.answers.where(correct: false).take)
  	end


  	it 'displays result correctly' do
  		expect(subject).to eq(  [
  								   {:points=>2, :uuid=>participant2.authorization_key, :name=>participant2.name, :correct_answers_number=>2, :wrong_answers_number=>0},
  							       {:points=>1, :uuid=>participant1.authorization_key, :name=>participant1.name, :correct_answers_number=>1, :wrong_answers_number=>1},
  								   {:points=>0, :uuid=>participant3.authorization_key, :name=>participant3.name, :correct_answers_number=>0, :wrong_answers_number=>0},
  							       {:points=>0, :uuid=>participant4.authorization_key, :name=>participant4.name, :correct_answers_number=>0, :wrong_answers_number=>0}
  							    ]
  			)
  	end

  end
end
