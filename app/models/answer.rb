class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :participant_answers

  def correct?
  	correct
  end
  
end
