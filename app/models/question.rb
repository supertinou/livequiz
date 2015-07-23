class Question < ActiveRecord::Base
  include RankedModel

  belongs_to :quiz
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  
  ranks :row_order , with_same: :quiz_id
  
  validates :title, presence: true

  validate :answers do 
    errors.add('', "should have at least two answers defined") if answers.length < 2
    errors.add('', "should have only one correct answer") if answers.where(correct: true).size > 1
    errors.add('', "should have a correct answer") if answers.reject {|answer| !answer.correct? }.size < 1
  end

  def row_order_index
  	Question.where(quiz_id: quiz_id).where("row_order < ?", row_order).count
  end

end
