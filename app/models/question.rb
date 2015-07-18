class Question < ActiveRecord::Base
  belongs_to :quiz

  validates :title, presence: true
end
