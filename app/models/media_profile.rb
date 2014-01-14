class MediaProfile < ActiveRecord::Base
  attr_accessible :company_name, :designation, :email, :media_type, :name, :office_phone, :phone, :title
  attr_accessible :personal_email

  has_one :address, as: :addressable, dependent: :destroy
  has_many :attendances, class_name: Attendee, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true


  validates :name, presence: true
  validates :company_name, presence: true

  class << self
    def titles
      ['Cik','Encik', 'Tuan', 'Puan', 'Datuk', 'Dato', 'Datin', 'Tan Sri']
    end

    def media_types
      ['Media Cetak', 'Media Elektronik', 'Dalaman - Ahli Majlis MPS', 'Dalaman - Pengarah Jabatan MPS']
    end

    def filter_by_type(media_type)
      self.where(media_type: media_type)
    end
  end


end
