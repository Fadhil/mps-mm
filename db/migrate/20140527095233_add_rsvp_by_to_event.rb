class AddRsvpByToEvent < ActiveRecord::Migration
  def change
    add_column :events, :rsvp_by, :date
  end
end
