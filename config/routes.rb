Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/merchants/find", to: 'merchants#find'
      get "/merchants/find_all", to: 'merchants#find_all'
      resources :merchants, only: [:index, :show] do
        resources :items, action: :index, controller: 'merchant_items'
      end
      resources :items do
        resources :merchant, action: :show, controller: 'item_merchants'
      end
    end
  end
end
