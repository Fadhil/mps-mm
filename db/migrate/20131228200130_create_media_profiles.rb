class CreateMediaProfiles < ActiveRecord::Migration
  def change
    create_table :media_profiles do |t|
      t.string :media_type
      t.string :title
      t.string :name
      t.string :designation
      t.string :company_name
      t.string :office_phone
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
