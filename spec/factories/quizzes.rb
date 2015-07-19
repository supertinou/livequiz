FactoryGirl.define do
  factory :quiz do
    title "My awesome Quizz"
    owner_email "lagrangemartin@gmail.com"

    factory :quiz_with_questions_and_answers do

    	after(:build) do |quiz|
          quiz.questions << FactoryGirl.create_list(:question_with_answers, 2, quiz: quiz)
        end

    end
  end
end
