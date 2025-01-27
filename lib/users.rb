require "users/version"
require "users/engine"

module Users
  mattr_accessor :user_class

  def self.user_class
    @@user_class.constantize
  end
end
