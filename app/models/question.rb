class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validate :answers do 
    errors.add(:answers, "should have at least two answers") if self.answers.length < 2
  end
end
