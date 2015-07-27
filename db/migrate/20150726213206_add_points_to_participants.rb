class AddPointsToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :points, :integer, :null => false, :default => 0
  end
end
