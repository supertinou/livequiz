class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true

  validate :answers do 
    errors.add('', "should have at least two answers defined") if answers.length < 2
    errors.add('', "should have only one correct answer") if answers.where(correct: true).size > 1
    errors.add('', "should have a correct answer") if answers.reject {|answer| !answer.correct? }.size < 1
  end

end
