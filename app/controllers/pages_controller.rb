class PagesController < ApplicationController
  def index
    @users = User.all
    @json = Location.all.to_gmaps4rails do |location, marker|
    @note=location.users
    
    @note.each do |note|
    @string="#{@string} #{note.last_name} #{note.first_name} \n"
    end

  marker.title   @string
  marker.json({ :id => location.id, :foo => "bar" })
end
  end
end
