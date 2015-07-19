class Quiz < ActiveRecord::Base
	validates :owner_email, email: true
	validates :owner_email, :title, :access_key, :access_password, presence: true
	validates :access_key, :access_password, uniqueness: true, on: :create	

	before_validation :generate_access_key, :generate_access_password, on: :create

	has_many :questions, dependent: :destroy
  	accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  	validate :questions do 
    	errors.add(:questions, "should have at least one question") if self.questions.length <= 0
  	end

	def generate_access_key
		 begin
    		self.access_key = SecureRandom.hex(8)
  		 end while self.class.exists?(access_key: access_key) 
	end

	def generate_access_password
		 begin
    		self.access_password = SecureRandom.hex(8)
  		 end while self.class.exists?(access_password: access_password)
	end

	def to_param
		access_key
	end

end
