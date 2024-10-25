Rails.application.routes.draw do
  root   "posts#index"
  get    "/privacy_policy",    to: "static_pages#privacy_policy"
  get    "/about",   to: "static_pages#about"
  get    "/terms", to: "static_pages#terms"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  get    "/signup",  to: "users#new"
  resources :account_activations, only: [:edit] 
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :posts
  resources :friend_requests
  resources :friendships, only: [:index, :show, :create, :destroy]
end