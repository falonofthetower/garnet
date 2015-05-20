Rails.application.routes.draw do
  get 'home', to: "trials#index"
  get 'login', to: "sessions#new"
  get 'logout', to: "sessions#destroy"
  get 'register', to: "users#new"

  resources :trials, only: [:index, :new, :create]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create]
end
