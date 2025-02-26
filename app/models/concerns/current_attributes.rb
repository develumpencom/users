module CurrentAttributes
  extend ActiveSupport::Concern

  included do
    attribute :session
    delegate :user, to: :session, allow_nil: true
  end
end
