Rails.application.routes.draw do
  resources :books, except: [:destroy] do
    get 'drafts', on: :collection
  end
  devise_for :users

  root to: 'books#index'
end
