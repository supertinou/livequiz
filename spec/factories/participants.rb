FactoryGirl.define do
  factory :participant do
    session nil
	sequence(:email)  { |n| "email-#{n}@provider.com" }
	sequence(:name)  { |n| "User-#{n}" }
  end

end
