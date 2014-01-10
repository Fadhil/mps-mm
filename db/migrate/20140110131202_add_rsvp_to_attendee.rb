class AddRsvpToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :rsvp, :boolean
  end
end
