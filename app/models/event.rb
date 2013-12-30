class Event < ActiveRecord::Base
  attr_accessible :date, :official, :organizer, :time, :venue
  attr_accessible :letter, :agenda_details, :name

  validates :name, presence: true
  validates :date, presence: true
  validates :venue, presence: true

  mount_uploader :agenda_details, AgendaDetailsUploader

  mount_uploader :letter, LetterUploader
end
