class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || home_path
  end

  def after_sign_out_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || login_path
  end

  def after_sign_up_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || home_path
  end

end
