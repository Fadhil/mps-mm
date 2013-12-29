class Address < ActiveRecord::Base
  attr_accessible :addressable_id, :addressable_type, :city_id, :line1, :line2, :postcode
  belongs_to :addressable, polymorphic: true
  belongs_to :city
  accepts_nested_attributes_for :city
end
