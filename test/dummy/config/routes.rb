Rails.application.routes.draw do
  mount Users::Engine => "/users"

  root to: "home#show"
end
