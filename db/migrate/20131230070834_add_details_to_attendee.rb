class AddDetailsToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :name, :string
    add_column :attendees, :email, :string
    add_column :attendees, :company_name, :string
    add_column :attendees, :phone, :string
  end
end
