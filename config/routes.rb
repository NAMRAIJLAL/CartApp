Rails.application.routes.draw do
  devise_for :users
  root 'welcomes#index'
  resources :welcomes

 
  resources :store
  resources :usercart
  namespace :api do
    namespace :v1 do
      resources :store, only: [:show, :index]
      resources :welcomes, only: [:index, :show]
    end
  end
  # get '/add/:id', to: 'store#productedit', as: 'add'
  # patch '/submit/:id', to: 'store#productupdate', as: 'submit'
  
   # get 'signin', to: 'sessions#new'
  # post 'signin', to: 'sessions#create'
  # devise_for :users, cSontrollers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
