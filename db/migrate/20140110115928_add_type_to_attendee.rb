class AddTypeToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :type, :string
  end
end
