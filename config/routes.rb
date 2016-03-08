Rails.application.routes.draw do
  root "home#show"

  get "dashboard", to: "dashboards#show"
  post "dashboard", to: "dashboards#show"

  resources :channels, only: [:index, :create, :new, :destroy]

  get "auth/slack", as: :login
  get "auth/:provider/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
