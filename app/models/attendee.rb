class Attendee < ActiveRecord::Base
  attr_accessible :attendance_list_id, :attendance_status, :attended, :media_profile_id
  attr_accessible :email_read, :letter
  belongs_to :attendance_list
  has_one :event, through: :attendance_list
  belongs_to :media_profile
  
  mount_uploader :letter, LetterUploader

  def full_name
    self.try(:media_profile).try(:name) || self.try(:name)
  end 

  def get_email
    self.try(:media_profile).try(:email) || self.try(:email)
  end

  def get_company_name
    self.try(:media_profile).try(:company_name) || self.try(:company_name)
  end
end
