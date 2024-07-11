Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "products#index"
  get 'pages/about'
  resources :customers
  resources :provinces
  resources :orders
  resources :customer_addresses
  resources :order_items
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
  get 'about', to: 'pages#about'  
  get '404', to: 'pages#404'
  get 'search', to: 'search#index'
  get 'search/results', to: 'search#results', as: 'search_results'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
