class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :media_profile_id
      t.boolean :attended
      t.integer :attendance_list_id
      t.string :attendance_status

      t.timestamps
    end
  end
end
