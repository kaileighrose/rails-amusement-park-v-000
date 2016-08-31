Rails.application.routes.draw do
  resources :users
  resources :attractions
  resources :rides

  root "users#home"

  get "/signup", to: "users#new"
  get "/signin", to: "users#signin"
  post "/login", to: "users#login"
  post "/attractions/:id/goonride", to: "attractions#goonride"
end