class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :username, :login

  attr_accessor :login

  def login=(login)
  @login = login
end

def login
  unless @login
    if self.username
      self.username
    else
      self.email
    end
  else
    @login
  end
end
  # attr_accessible :title, :body

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     where(conditions).first
  #   end
  # end

  def self.find_for_authentication(conditions={})
   self.where("username = ?", conditions[:login]).limit(1).first ||
    self.where("email = ?", conditions[:login]).limit(1).first
    #super
  end
end
