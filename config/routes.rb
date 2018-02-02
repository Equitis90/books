Rails.application.routes.draw do
  resources :books, except: [:destroy]

  devise_for :users

  root to: 'books#index'
end
