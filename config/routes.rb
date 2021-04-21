Rails.application.routes.draw do
  
  root "notes#index"
  resources :notes #plural
  resources :users 
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
