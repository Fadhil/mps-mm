class AddLetterToEvent < ActiveRecord::Migration
  def change
    add_column :events, :letter, :string
  end
end
