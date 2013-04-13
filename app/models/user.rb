class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:imageurl,:ProfileUrl
  attr_accessible :birthdate, :location_id, :email, :first_name, :address, :group, :last_name, 
                  :promotion, :temporary_profile, :encrypted_password, :specialization

  has_many :educations, :foreign_key => "user_id" 
  has_many :experiences, :foreign_key => "user_id"
  belongs_to :location
  
  # Validari - trebuie completat
  validates :email, :presence => { :message => " Trebuie completat ! " }
  validates :group, :presence => { :message => " Trebuie completat ! " }
  validates :promotion, :presence => { :message => " Trebuie completat ! " }
  validates :specialization, :presence =>  { :message => " Trebuie completat ! " }

  # Validari speciale
  validates_numericality_of :group, :only_integer => true, :greater_than_or_equal_to => 300
  validates_numericality_of :promotion, :only_integer => true, :greater_than_or_equal_to => 1900


  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
    end
  end


end
