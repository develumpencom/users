module Users
  class Session < ApplicationRecord
    belongs_to :user, class_name: "::User"
  end
end
