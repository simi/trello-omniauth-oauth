Rails.application.routes.draw do
  root to: 'integrations#index'
  get '/auth/:provider/callback', to: 'integrations#create'
  resources :notifications, only: :create
end
