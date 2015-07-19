class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.references :session, index: true, foreign_key: true
      t.string :email
      t.string :authorization_key
      t.string :authorization_password
      t.string :name

      t.timestamps null: false
    end
  end
end
