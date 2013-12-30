class Attendee < ActiveRecord::Base
  attr_accessible :attendance_list_id, :attendance_status, :attended, :media_profile_id
  belongs_to :attendance_list
  has_one :event, through: :attendance_list
  belongs_to :media_profile
  
end
