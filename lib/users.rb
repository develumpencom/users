require "users/version"
require "users/engine"
require "faraday"
require "jwt"

module Users
  mattr_accessor :user_class

  def self.user_class
    @@user_class.constantize
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end

class Users::Configuration
  include ActiveSupport::Configurable

  config_accessor :oauth_server_url,
                  :breakable_toys_client_id,
                  :breakable_toys_client_secret,
                  :disable_form_access

  def initialize
    self.disable_form_access = false
  end
end
