Rails.application.routes.draw do
  resources :favorites
  resources :users
  resources :sessions
  resources :movies
  resources :restaurants
  resources :events
  resources :concerts
  resources :bars

  post 'signin', to: 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
