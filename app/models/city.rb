class City < ActiveRecord::Base
  attr_accessible :name, :state_name
  has_many :addresses
end
