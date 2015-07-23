require 'rails_helper'

RSpec.describe Question, :type => :model do

  let(:quiz) { FactoryGirl.create :quiz_with_questions_and_answers }
  let(:ordered_questions) {quiz.questions.rank(:row_order)}

  describe "#row_order_index" do 
  	it 'should be in the right row_order_index' do
  		expect(quiz.questions.count).to eq(4)

  		expect(ordered_questions[0].row_order_index).to eq(0)
  		expect(ordered_questions[1].row_order_index).to eq(1)
  		expect(ordered_questions[2].row_order_index).to eq(2)
  		expect(ordered_questions[3].row_order_index).to eq(3)
  	end
  end

  describe "#format" do 

    let(:question) { FactoryGirl.create :question_with_answers }

    context 'format=:title_with_answers' do

      it 'display with proper format' do
        expect(question.answers.count).to eq(4)
        expected_hash = {
                            :title=>"Which color is the sky ?", 
                            :answers=>[
                                        {:id=>question.answers[0].id, :title=>"blue"},
                                        {:id=>question.answers[1].id, :title=>"red"},
                                        {:id=>question.answers[2].id, :title=>"white"},
                                        {:id=>question.answers[3].id, :title=>"green"}
                                      ]
                        }

        expect(question.format(:title_with_answers)).to eq(expected_hash)
      end

    end
    context 'unknown format' do

    end
  end

end
