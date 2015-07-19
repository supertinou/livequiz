class Participant < ActiveRecord::Base
  belongs_to :session
  
  validates :email, email: true
  validates :email, uniqueness: { scope: :session, message: "cannot be used more than one time" }

  validates :email, :authorization_key, :authorization_password, presence: true

  before_validation :generate_authorization_key, :generate_authorization_password, on: :create

  private

  def generate_authorization_key
		 begin
    		self.authorization_key = SecureRandom.hex(8)
  	 end while self.class.exists?(authorization_key: authorization_key)
	end

	def generate_authorization_password
		 begin
    		self.authorization_password = SecureRandom.hex(8)
  	 end while self.class.exists?(authorization_password: authorization_password)
	end

end
