class MediaProfile < ActiveRecord::Base
  attr_accessible :company_name, :designation, :email, :media_type, :name, :office_phone, :phone, :title
  attr_accessible :personal_email, :media_name, :address_attributes

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
        where('media_type like :search OR 
                                  title like :search OR 
                                  name like :search OR 
                                  designation like :search OR
                                  company_name like :search OR
                                  office_phone like :search OR
                                  phone like :search OR
                                  email like :search OR
                                  personal_email like :search OR
                                  media_name like :search', { search: "%#{terms}%"}).order('name asc')
      else
        all.order('name asc')
      end
    end
  end



end
