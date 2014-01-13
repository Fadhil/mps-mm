class Event < ActiveRecord::Base
  attr_accessible :date, :official, :organizer, :time, :venue
  attr_accessible :letter, :agenda_details, :name

  has_one :attendance_list, dependent: :destroy
  has_many :attendees, through: :attendance_list

  validates :name, presence: true
  validates :date, presence: true
  validates :venue, presence: true

  mount_uploader :agenda_details, AgendaDetailsUploader

  mount_uploader :letter, LetterUploader

  def generate_attendance_list
    if self.attendance_list.nil?
      self.attendance_list = AttendanceList.create
    end
  end

  def add_participant(p)
    media_profile = p
    self.generate_attendance_list
    attendee = self.attendance_list.attendees.where(media_profile_id: media_profile).first || self.attendance_list.attendees.create(media_profile_id: media_profile.id)
    self.save
    attendee
  end

  def attendees_list
    attendees = {}
    self.attendance_list.attendees.sort{ |x,y| y.full_name <=> x.full_name}.each do |a|
      media_type = a.try(:media_profile).try(:media_type) || 'walkin'
      attendees[media_type] = [] unless attendees[media_type]
      attendee_details = {}
      attendee_details[:full_name] = "#{a.try(:full_name)}".strip
      attendee_details[:media_profile_id] = a.try(:media_profile).try(:id)
      attendee_details[:attendee_id] = a.id
      attendee_details[:full_name] = "#{a.try(:media_profile).try(:title)} #{a.media_profile.try(:name)}".strip
      attendee_details[:email] = a.try(:media_profile).try(:email)
      attendee_details[:company_name] = a.try(:media_profile).try(:company_name)
      attendee_details[:attendance_status] = a.try(:attendance_status)
      attendee_details[:rsvp_response] = a.try(:rsvp)
      attendee_details[:event_id] = self.id
      attendees[media_type] << attendee_details
     
    end


    attendees
  end


  class << self

  end
end
