Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: 'ocalls' }

  get 'products/userview', to: 'products#userview'
  get 'products/redirect_after_sign_in', to: 'products#redirect_after_sign_in'
  get 'products/check_role', to: 'products#check_role'
  
  resources :carts
  resources :products do
    resources :comments
    collection do
      get :by_category
    end
  end

  resources :categories, except: [:edit, :update]

  root 'products#redirect_after_sign_in'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 

