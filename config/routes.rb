Rails.application.routes.draw do
  root "home#show"

  get 'https://slack.com/oauth/authorize', as: :login
  get 'auth/:provider/callback', to: "sessions#create"
  
end
