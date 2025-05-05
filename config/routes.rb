Rails.application.routes.draw do
  root to: 'tables#index'
  resources :tables

  resources :dish_and_drinks , only: [:index, :update, :show] do
    get :bar, on: :collection
    get :dishes, on: :collection
    get :search, on: :collection
    get :create
  end
  resources :feedbacks_and_suggestions, only: [:index, :new, :create]

  resources :payments, only: [:index] do
    member do
      get :pay
      post :pay
    end
  end

  resources :account, only: [:index]
  delete "/logout", to: "account#logout", as: :logout

  resources :employees, only: [:index, :show, :create, :update, :destroy] do
    get :create
  end

  resources :chip_baskets, only: [:index, :create, :update, :destroy]
  resources :orders, only: [:create, :update, :show] do
    member do
      patch :accept_order
      patch :mark_paid
    end
    patch 'mark_dish_done/:order_item_id', to: 'orders#mark_dish_done', as: :mark_dish_done
  end

  resources :managers do
    get :used_ingredients, on: :collection
    get :popular_dish, on: :collection
    get :tables_served_by_a_waitor, on: :collection
    get :waitor_of_tables, on: :collection
    patch :waitor_of_tables
    get :dish_and_drink, on: :collection
    get :table, on: :collection
    get :show
  end
end


