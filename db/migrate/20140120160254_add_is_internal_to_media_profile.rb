class AddIsInternalToMediaProfile < ActiveRecord::Migration
  def change
    add_column :media_profiles, :is_internal, :boolean
  end
end
