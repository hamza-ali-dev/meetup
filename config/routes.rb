Rails.application.routes.draw do
  resources :groups
  mount Sidekiq::Web => '/sidekiq'
end
