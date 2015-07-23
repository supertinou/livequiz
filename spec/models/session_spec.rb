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

end
