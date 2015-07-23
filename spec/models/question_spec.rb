require 'rails_helper'

RSpec.describe Question, :type => :model do
  describe "#row_order_index" do 
  	let(:quiz) { FactoryGirl.create :quiz_with_questions_and_answers }
  	let(:ordered_questions) {quiz.questions.rank(:row_order)}
  	it 'should be in the right row_order_index' do
  		expect(quiz.questions.count).to eq(4)

  		expect(ordered_questions[0].row_order_index).to eq(0)
  		expect(ordered_questions[1].row_order_index).to eq(1)
  		expect(ordered_questions[2].row_order_index).to eq(2)
  		expect(ordered_questions[3].row_order_index).to eq(3)
  	end
  end 
end
