require 'rails_helper'

RSpec.describe Participant, :type => :model do

  let(:quiz) { FactoryGirl.create :quiz_with_questions_and_answers }
  let(:quiz_session) { FactoryGirl.create :session, quiz: quiz }
  let(:participant1) { quiz_session.participants[0] }
  let(:participant2) { quiz_session.participants[1] }
  
  let(:question1) { quiz.questions[0]}
  let(:question2) { quiz.questions[1]}

  describe "#answer_question" do

  	subject { participant1.answer_question(question,answer) }
  	
  	let(:question) { question1 }

  	context 'question have not yet been already answered' do

  		context 'answer is correct' do

  			let(:answer){ question1.correct_answer }

  			it 'is a correct answer' do
  				expect(subject).to eq(true)
  			end

  		end

	    context 'answer is false' do

	    	let(:answer){ question1.answers.where(correct: false).take }

	    	it 'is a wrong answer' do
	    		expect(question).not_to eq(nil)
	    		expect(answer).not_to eq(nil)
	    		expect(subject).to eq(false)
	    	end
	  	end

  	end

  	context 'question have been already answered' do

  	end

  end 

  describe "#have_already_answered_the_question?" do 

  	subject{ participant1.have_already_answered_the_question?(question) }

  	let(:question) { question1 }
  	let(:answer1){ question.answers[0] }
  	let(:answer2){ question.answers[1] }

  	context "have answered the question" do

  		before do 
  			participant1.answer_question(question,answer1)
  		end

  		it 'is already answered' do 
  			expect(subject).to eq(true)
  		end


  	end

  	context "have not answered the question yet" do

  		it "is not already answered" do
  			expect(subject).to eq(false)
  		end
  	end

  end 


end
