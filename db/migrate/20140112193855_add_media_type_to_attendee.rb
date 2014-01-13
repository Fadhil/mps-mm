class AddMediaTypeToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :media_type, :string
  end
end
