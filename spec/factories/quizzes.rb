FactoryGirl.define do
  factory :quiz do
    title "My awesome Quizz"
    owner_email "lagrangemartin@gmail.com"

    factory :quiz_with_questions do
    	after(:create) do |quiz|
    		FactoryGirl.create(:question, quiz: quiz)
    	end
    end
  end
end
