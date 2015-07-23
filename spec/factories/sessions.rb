FactoryGirl.define do
  factory :session do
    quiz nil
	access_key "MyString"

	after(:build) do |session|
          session.participants << FactoryGirl.create_list(:participant, 4, session: session)
    end
  end

end
