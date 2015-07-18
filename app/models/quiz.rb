class Quiz < ActiveRecord::Base
	validates :owner_email, email: true
	validates :owner_email, :title, :access_key, :access_password, presence: true
	validates :access_key, :access_password, uniqueness: true, on: :create	

	before_validation :generate_access_key, :generate_access_password, on: :create

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

end
