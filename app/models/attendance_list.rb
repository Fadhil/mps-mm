class AttendanceList < ActiveRecord::Base
  attr_accessible :attendee_counter, :completed, :event_id
  has_many :attendees, dependent: :destroy
  belongs_to :event
end
