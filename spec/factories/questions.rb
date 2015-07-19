FactoryGirl.define do
  factory :question do
    title "Which color is the sky ?" 

	factory :question_with_answers do
		
		after(:build) do |question|

		  question.answers << FactoryGirl.build(:answer, title: 'blue', :question => question, correct: true)

		  %w[red white green].each do |color|
          	question.answers << FactoryGirl.build(:answer, title: color, :question => question)
          end
        end

	end
  end

end
