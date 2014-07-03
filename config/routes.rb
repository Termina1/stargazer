require 'sidekiq/web'

Rails.application.routes.draw do
  root 'main#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/about', to: 'main#about'
  resources :users do
    get :search, on: :member
    post :reindex, on: :member
  end
  mount Sidekiq::Web => '/sidekiq'
end
