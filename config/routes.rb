Rails.application.routes.draw do
  resources :trials, only: [:index]
  resources :users, only: [:new, :create]
end
