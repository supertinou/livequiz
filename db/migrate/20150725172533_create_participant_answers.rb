class CreateParticipantAnswers < ActiveRecord::Migration
  def change
    create_table :participant_answers do |t|
      t.references :participant, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true
      t.integer :response_time

      t.timestamps null: false
    end
  end
end
