Rails.application.routes.draw do
  root "home#show"

  get "auth/slack", as: :login
  get "auth/:provider/callback", to: "sessions#create"
  get "dashboard", to: "dashboards#show"
end
