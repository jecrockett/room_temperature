Rails.application.routes.draw do
  root "home#show"
  get "dashboard", to: "dashboards#show"

  get "auth/slack", as: :login
  get "auth/:provider/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
