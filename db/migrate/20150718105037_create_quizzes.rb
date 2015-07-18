class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :title
      t.string :owner_email

      t.timestamps null: false
    end
  end
end
