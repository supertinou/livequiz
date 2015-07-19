class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :quiz, index: true, foreign_key: true
      t.string :access_key

      t.timestamps null: false
    end
  end
end
