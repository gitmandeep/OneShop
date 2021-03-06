Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: 'ocalls' }

  get 'products/userview', to: 'products#userview'
  get 'products/redirect_after_sign_in', to: 'products#redirect_after_sign_in'
  get 'products/check_role', to: 'products#check_role'
  get 'users/:id/payment_history' => 'users#payment_history', as: :payment_history
  
  
  resources :charges do
    collection do
      get :cards_list
    end
  end
  
  resources :orders 
  resources :carts, only: [:show] do
    collection do
      get :add_to_cart
      get :iterate_quantity
      get :remove_item_from_cart
    end
  end

  resources :products do
    resources :comments
    collection do
      get :by_category
      get :order
    end
  end

  # resources :users, only: [:show]

  resources :categories, except: [:edit, :update] do
    collection do
      get :list_cat, as: :list_cat
    end
  end
  resources :users do
    resources :addresses 
  end
  root 'products#userview'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 

