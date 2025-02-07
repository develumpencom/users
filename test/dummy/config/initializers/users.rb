Users.user_class = "User"

Users.configure do |config|
  config.oauth_server_url = "http://localhost:3000"
  config.breakable_toys_client_id = Rails.application.credentials.breakable_toys.client_id
  config.breakable_toys_client_secret = Rails.application.credentials.breakable_toys.client_secret
end
