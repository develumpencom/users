class User < ApplicationRecord
  has_secure_password

  has_many :sessions, class_name: "Users::Session", dependent: :destroy
end
