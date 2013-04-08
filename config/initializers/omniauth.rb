Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "mgdh4gtnqnra", "adFWD50VxWY35Yi1", client_options: {request_token_path: '/uas/oauth/requestToken?scope=r_emailaddress+r_fullprofile'}, fields: ['id', 'first-name', 'last-name', 'headline', 'industry', 'picture-url', 'public-profile-url', 'picture-urls::(original)', 'email-address', 'positions', 'skills', 'educations', 'volunteer', 'associations', 'specialties', 'date-of-birth']
end
