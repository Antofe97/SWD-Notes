Rails.application.routes.draw do
  
  get 'users/index'
  root "notes#index"
  resources :notes #plural
  resources :users
  match '/users',   to: 'users#index',   via: 'get'
  
  
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
