Rails.application.routes.draw do
  resources :projects
  resources :clients
  resources :tasks, only: [:create, :update, :destroy]
  
  # Defines the root path route ("/")
  root "projects#index"
  
  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check
end
