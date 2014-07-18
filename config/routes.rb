require 'sidekiq/web'

Rails.application.routes.draw do
  root 'main#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/about', to: 'main#about'
  resources :users do
    get :search, on: :member
    post :reindex, on: :member
    post :reindex_only, on: :member
  end
  namespace :admin do
    mount Sidekiq::Web => '/sidekiq'
    get '/', to: 'admin#index'
    get '/users/:name', to: 'admin#user'
  end
end
