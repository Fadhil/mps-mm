class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.time :time
      t.string :venue
      t.string :official
      t.string :organizer

      t.timestamps
    end
  end
end
