Rails.application.routes.draw do
  root to: "trials#index"
  get 'home', to: "trials#index"
  get 'login', to: "sessions#new"
  get 'logout', to: "sessions#destroy"
  get 'register', to: "users#new"

  resources :trials, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create]
end
