Rails.application.routes.draw do
  root 'groups#index'

  resources :groups
  resources :users, only: :index do
    post :upload, on: :collection
  end

  mount Sidekiq::Web => '/sidekiq'
end
