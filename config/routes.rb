Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"

  ##====== Items
  # resources :items, only: [:index, :show, :edit, :update, :destroy]
  resources :items, except: [:create]
  
  ##====== Reviews
  # resources :reviews, only: [:edit, :update, :destroy]
  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  ##====== Cart
  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  patch "/cart", to: "cart#increment_decrement"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  ##====== Orders
  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show"

  ##====== Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  ##====== Users
  get '/register', to: "users#new"
  post '/register', to: "users#create"

  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile/password', to: "users#edit_password"
  patch '/profile/password', to: "users#update_password"
  get '/profile', to: 'users#show'
  get '/profile/orders', to: 'user_orders#index'
  get '/profile/orders/:id', to: 'user_orders#show'
  patch '/profile/orders/:id', to: 'orders#cancel'

  ##====== Merchants
  # resources :merchants do
  #   resources :items, only: [:index, :new, :create]
  # end
  resources :merchants
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"

  ##====== Merchant
  namespace :merchant do
    get '/', to: "dashboard#show"
    patch "/items/:id/:disable_enable", to: 'items#enable_disable'
    delete "/items/:id/destroy", to: 'items#destroy'
    get '/orders/:id', to: 'orders#show'
    resources :items, except: [:show]
  end

  ##====== Admin
  namespace :admin do
    get '/', to: 'dashboard#index'
    patch '/:id/ship', to: 'dashboard#update'
    resources :merchants, only: [:index, :show]
    resources :orders, only: [:index, :show]
    get '/merchant/:id', to: 'merchants#show'
    patch '/merchants/:id/:disable_enable', to: 'merchants#update'
  end
end
