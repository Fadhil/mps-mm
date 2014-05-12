class MediaProfile < ActiveRecord::Base
  attr_accessible :company_name, :designation, :email, :media_type, :name, :office_phone, :phone, :title
  attr_accessible :personal_email, :media_name, :address_attributes

  has_one :address, as: :addressable, dependent: :destroy
  has_many :attendances, class_name: Attendee, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  before_save :set_internal


  validates :name, presence: true
  validates :company_name, presence: true

  def set_internal
    if self.media_type.in?(['MPS - Ahli Majlis','MPS - Pengarah Jabatan'])
      self.is_internal = true
    else
      self.is_internal = false
    end
    true
  end

  class << self
    def titles
      ['Cik','Encik', 'Tuan', 'Puan', 'Datuk', 'Dato', 'Datin', 'Tan Sri']
    end

    def media_types
      ['Media Cetak', 'Media Elektronik', 'MPS - Ahli Majlis', 'MPS - Pengarah Jabatan']
    end

    def filter_by_type(media_type)
      if media_type.to_sym == :all_media
        self.order('name asc')
      else
        self.where(media_type: media_type).order('name asc')
      end
    end

    def search(terms)
      if terms
        terms = terms.split(' ').join('%')
        where('lower(media_type) like :search OR 
                                  lower(title) like :search OR 
                                  lower(name) like :search OR 
                                  lower(designation) like :search OR
                                  lower(company_name) like :search OR
                                  lower(office_phone) like :search OR
                                  phone like :search OR
                                  lower(email) like :search OR
                                  lower(personal_email) like :search OR
                                  lower(media_name) like :search', { search: "%#{terms.downcase}%"}).order('name asc')
      else
        order('name asc')
      end
    end
  end



end
