Rails.application.routes.draw do

  # get 'home/index'
  # #devise_for :users
root :to => "home#index"

resources :products
  devise_for :users do
  get 'logout' => 'devise/sessions#destroy'
  end
  require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
