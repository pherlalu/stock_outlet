Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "products#index"

  resources :customers
  resources :provinces
  resources :orders, only: [:index, :show]
  resources :customer_addresses
  resources :order_items
  resources :invoices

  resources :products, only: [:index, :show] do
    member do
      post 'add_to_cart'
      patch 'update_cart'
      delete 'remove_from_cart'
    end
  end

  resources :carts, only: [:create, :show, :destroy, :update] do
    get "checkout", on: :member, to: "carts#checkout"
    post "stripe_session", on: :member, to: "carts#stripe_session"
    get "success", on: :member, to: "carts#success"
  end

  resources :categories, path: 'categories', only: [:index, :show], param: :name do
    collection do
      get '', to: 'categories#index', as: 'index'
    end
    member do
      get ':sub_category_name', to: 'categories#show', as: 'sub_category'
    end
  end

  get 'about', to: 'pages#about'
  get '404', to: 'pages#404'
  get 'search', to: 'search#index'
  get 'search/results', to: 'search#results', as: 'search_results'
  get '/pages/:slug', to: 'pages#show', as: 'page'
  get "up" => "rails/health#show", as: :rails_health_check
end
