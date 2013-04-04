class SessionsController < ApplicationController

def create
  auth = request.env["omniauth.auth"]
  @user = User.find_by_email(auth['info']['email']) 
  session[:user_id] = @user.id
  users#create_from_linkedin(auth)
 
if @user
  sign_in @user
 

  Rails.logger.debug "lalal"
  raise "IS USER"
  redirect_to home_path, :notice => "Signed in!"
  else 
    raise "IS NOT USER"
    redirect_to root_path
  end
end

def destroy
  session[:user_id] = nil
  redirect_to home_path, :notice => "Signed out!"
end
end
