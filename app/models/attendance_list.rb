class AttendanceList < ActiveRecord::Base
  attr_accessible :attendee_counter, :completed, :event_id
  attr_accessible :attendees_attributes, :walkins_attributes
  has_many :attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees
  has_many :walkins, dependent: :destroy
  accepts_nested_attributes_for :walkins
  belongs_to :event
end
