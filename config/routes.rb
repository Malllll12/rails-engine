Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchants_search#index'
      get '/merchants/find', to: 'merchants_search#show'

      get '/items/find_all', to: 'items_search#index'

      resources :merchants, only: [:index, :show] do
        resources :items, action: :index, controller: 'merchant_items'
      end

      resources :items do
        resources :merchant, action: :show, controller: 'item_merchants'
      end
    end
  end
end
