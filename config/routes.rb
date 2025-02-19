Users::Engine.routes.draw do
  get "oauth/auth"
  get "oauth/callback"

  resource :session, only: Users.configuration.disable_form_access ? %i[destroy] : %i[new create destroy]
end
