class Walkin < Attendee
  attr_accessible :name, :email, :company_name, :phone, :media_type
  before_create :create_media_profile

  def create_media_profile
   
    m = MediaProfile.create(name: self.name, email: self.email, company_name: self.company_name, phone: self.phone, media_type: self.media_type)
    self.media_profile_id = m.id
  end
end