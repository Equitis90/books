Rails.application.routes.draw do
  get 'books/drafts'
  resources :books, except: [:destroy]
  devise_for :users

  root to: 'books#index'
end
