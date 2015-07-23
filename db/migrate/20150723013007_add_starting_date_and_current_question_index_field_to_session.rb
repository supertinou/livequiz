class AddStartingDateAndCurrentQuestionIndexFieldToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :starting_date, :datetime
    add_column :sessions, :current_question_index, :integer
  end
end
