Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :customers
  resources :provinces
  resources :orders
  resources :customer_addresses
  resources :order_items
  resources :products
  resources :products
  
  resources :categories, path: 'categories', only: [:index, :show], param: :name do
    collection do
      get '', to: 'categories#index', as: 'index'
    end
    member do
      get ':sub_category_name', to: 'categories#show', as: 'sub_category'
    end
  end

  resources :invoices
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
