class SessionsController < ApplicationController
def create
  auth = request.env["omniauth.auth"]
  @user = User.find_by_uid(auth["uid"])||User.find_by_email(auth['info']['email']) 
  session[:user_id] = @user.id
  users#create_from_linkedin(auth)
  sign_in @user
  redirect_to home_path, :notice => "Signed in!"
end

def destroy
  session[:user_id] = nil
  redirect_to home_path, :notice => "Signed out!"
end
end
