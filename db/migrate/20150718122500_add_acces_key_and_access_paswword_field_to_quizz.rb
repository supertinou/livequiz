class AddAccesKeyAndAccessPaswwordFieldToQuizz < ActiveRecord::Migration
  def change
    add_column :quizzes, :access_key, :string
    add_column :quizzes, :access_password, :string
  end
end
