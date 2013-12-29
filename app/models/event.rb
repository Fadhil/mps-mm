class Event < ActiveRecord::Base
  attr_accessible :date, :official, :organizer, :time, :venue
  attr_accessible :letter, :agenda_details

  mount_uploader :agenda_details, AgendaDetailsUploader

  mount_uploader :letter, LetterUploader
end
