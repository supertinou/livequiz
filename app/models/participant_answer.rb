class ParticipantAnswer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :answer

  validates :participant, :answer, presence: true

  validate :answer do 
  	if participant.have_already_answered_the_question?(answer.question)
  		errors.add('answer', "could not be created because the question have already been answered with another answer") 
  	end
  end

end
