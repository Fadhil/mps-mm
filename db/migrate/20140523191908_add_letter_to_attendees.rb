class AddLetterToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :letter, :string
  end
end
