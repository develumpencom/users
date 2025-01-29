Users::Engine.routes.draw do
  resource :session, only: %i[new create destroy ]
end
