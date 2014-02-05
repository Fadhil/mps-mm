class AddIndexToEvent < ActiveRecord::Migration
  def up
    add_index :events, :name
  end

  def down
    remove_index :events, :name
  end
end
