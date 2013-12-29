class Event < ActiveRecord::Base
  attr_accessible :date, :official, :organizer, :time, :venue
end
