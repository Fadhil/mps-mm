class AddPersonalEmailToMediaProfile < ActiveRecord::Migration
  def change
    add_column :media_profiles, :personal_email, :string
  end
end
