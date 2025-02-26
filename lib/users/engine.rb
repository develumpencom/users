module Users
  class Engine < ::Rails::Engine
    isolate_namespace Users

    config.to_prepare do
      if defined?(::Current) && ::Current < ActiveSupport::CurrentAttributes
        ::Current.include CurrentAttributes
      end
    end
  end
end
