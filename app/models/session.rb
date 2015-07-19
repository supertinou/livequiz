class Session < ActiveRecord::Base
  belongs_to :quiz
  before_validation :generate_access_key, on: :create
  validates :quiz, presence: true

  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants, reject_if: :all_blank, allow_destroy: true

  validate :participants do 
   	errors.add(:participants, "should not be empty") if self.participants.length <= 0
  end

  def generate_access_key
		begin
    		self.access_key= SecureRandom.hex(8)
  		end while self.class.exists?(access_key: access_key)
  end

  def to_param
	   access_key
  end

end
