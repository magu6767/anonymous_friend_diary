Rails.application.routes.draw do
  root   "posts#index"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  get    "/signup",  to: "users#new"
  resources :account_activations, only: [:edit] 
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts
  resources :friend_requests
end