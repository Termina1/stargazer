Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '38162c3ec82d084a5802', '630ceb08140b6331e3f48b3e4dad3275ed9a9e9a'
end