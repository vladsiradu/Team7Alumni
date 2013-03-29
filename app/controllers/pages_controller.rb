class PagesController < ApplicationController
  def index
    @users = User.all
    @json = User.all.to_gmaps4rails
  end
end
