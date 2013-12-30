class CreateAttendanceLists < ActiveRecord::Migration
  def change
    create_table :attendance_lists do |t|
      t.integer :event_id
      t.integer :attendee_counter
      t.boolean :completed

      t.timestamps
    end
  end
end
