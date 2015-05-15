Rails.application.routes.draw do
  resources :trials, only: [:index]
end
