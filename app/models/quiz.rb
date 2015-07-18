class Quiz < ActiveRecord::Base
	validates :owner_email, email: true
	validates :owner_email, :title, presence: true
end
