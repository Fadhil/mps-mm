class AddDefaultToIsInternal < ActiveRecord::Migration
  def up
    change_column :media_profiles, :is_internal, :boolean, default: false
  end

  def down
    change_column :media_profiles, :is_internal, :boolean, default: nil
  end
end
