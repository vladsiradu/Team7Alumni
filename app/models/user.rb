class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:imageurl
  attr_accessible :birthdate, :location, :email, :first_name, :group, :last_name, :promotion, :temporary_profile, :encrypted_password, :specialization

has_many :education, :foreign_key => "user_id" 
has_many :experience, :foreign_key => "user_id" 
end
