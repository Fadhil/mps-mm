class AddFieldsToMediaProfile < ActiveRecord::Migration
  def change
    add_column :media_profiles, :media_name, :string
  end
end
