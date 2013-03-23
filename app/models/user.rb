class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :birthdate, :email, :first_name, :group, :last_name, :promotion, :temporary_profile, :encrypted_passwordm, :address, :latitude, :longitude

has_many :education, :foreign_key => "user_id" 
has_many :experience, :foreign_key => "user_id"

# can also be an IP address
geocoded_by :address
# auto-fetch coordinates
after_validation :geocode

reverse_geocoded_by :latitude, :longitude
# auto-fetch address
after_validation :reverse_geocode  

acts_as_gmappable :process_geocoding => false

def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
  address
end
end
