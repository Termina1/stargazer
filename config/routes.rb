Rails.application.routes.draw do
  root 'main#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/about', to: 'main#about'
  resources :users do
    get :search, on: :member
  end
  mount Sidekiq::Web => '/sidekiq'
end
