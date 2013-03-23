Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "mgdh4gtnqnra", "adFWD50VxWY35Yi1", client_options: {request_token_path: '/uas/oauth/requestToken?scope=r_emailaddress+r_fullprofile+r_basicprofile'}, fields: ['id', 'first-name', 'last-name', 'headline', 'industry', 'picture-url', 'public-profile-url', 'email-address', 'positions', 'skills', 'educations', 'volunteer', 'associations', 'specialties'] 
end
