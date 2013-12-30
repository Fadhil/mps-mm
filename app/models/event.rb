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

    self.attendance_list.attendees.create(media_profile_id: media_profile.id)
    self.save
  end
end
