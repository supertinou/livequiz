require "live_quiz/pub_nub"

class Session < ActiveRecord::Base
  belongs_to :quiz
  before_validation :generate_access_key, on: :create
  validates :quiz, presence: true

  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants, reject_if: :all_blank, allow_destroy: true

  validate :participants do 
   	errors.add(:participants, "should not be empty") if self.participants.length <= 0
  end

  after_commit :set_forbidden_access_to_session_channels, on: [:create,:destroy]

  def to_param
     access_key
  end

  def server_channel
      "#{access_key}-server"
  end

  def client_channel
      "#{access_key}-client"
  end

  def chat_channel
      "#{access_key}-chat"
  end

  private

  def generate_access_key
		begin
    		self.access_key= SecureRandom.hex(8)
  		end while self.class.exists?(access_key: access_key)
  end

  def set_forbidden_access_to_session_channels
      [server_channel,client_channel,chat_channel].each do |chan| 
        LiveQuiz::PubNub.client.grant(channel: chan, read: false, write: false){|envelope|}
      end

  end

end
