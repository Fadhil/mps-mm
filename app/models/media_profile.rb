class MediaProfile < ActiveRecord::Base
  attr_accessible :company_name, :designation, :email, :media_type, :name, :office_phone, :phone, :title

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
end
