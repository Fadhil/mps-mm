class AddEmailReadToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :email_read, :boolean
  end
end
