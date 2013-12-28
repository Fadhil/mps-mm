class Address < ActiveRecord::Base
  attr_accessible :addressable_id, :addressable_type, :city_id, :line1, :line2, :postcode
end
