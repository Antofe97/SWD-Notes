Rails.application.routes.draw do
  resources :collections
  resources :users #, only: [:new, :create, :index, :show, :edit]
  get 'users/:id/notes', to: "notes#user_notes"
  get 'users/:id/collections', to: "collections#user_collections"

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  
  resources :notes #plural 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
