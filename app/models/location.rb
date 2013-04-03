class Location < ActiveRecord::Base
  attr_accessible :gmaps, :latitude, :longitude, :name
  has_many :users, :foreign_key => :location_id

  # can also be an IP address
  geocoded_by :name
  # auto-fetch coordinates
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude

  # auto-fetch address
  after_validation :reverse_geocode  

  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_location
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    name
  end

  def address=(val)
  end


end
