Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.secrets.github_client, Rails.application.secrets.github_secret
end