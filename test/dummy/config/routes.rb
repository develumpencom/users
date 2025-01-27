Rails.application.routes.draw do
  mount Users::Engine => "/"

  root to: "home#show"
end
