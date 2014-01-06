class MediaProfile < ActiveRecord::Base
  attr_accessible :company_name, :designation, :email, :media_type, :name, :office_phone, :phone, :title

  has_one :address, as: :addressable, dependent: :destroy
  has_many :attendances, class_name: Attendee, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true


  validates :name, presence: true
  validates :company_name, presence: true

  def self.titles
    ['Cik','Encik', 'Tuan', 'Puan', 'Datuk', 'Dato', 'Datin', 'Tan Sri']
  end

  def self.media_types
    ['Media Cetak', 'Media Elektronik', 'Dalaman - Ahli Majlis MPS', 'Dalaman - Pengarah Jabatan MPS']
  end

  def self.filter_by_type(media_type)
    self.where(media_type: media_type)
  end

end
