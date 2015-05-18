Rails.application.routes.draw do
  get 'home', to: "trials#index"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"

  resources :trials, only: [:index]
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create,]
end
