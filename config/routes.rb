Users::Engine.routes.draw do
  get "oauth/auth"
  get "oauth/callback"

  resource :session, only: %i[new create destroy ]
end
