require "sidekiq/web"
Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  scope "(:locale)", locale: /en|vi/ do
    mount Sidekiq::Web => "/sidekiq"
    devise_for :users, skip: :omniauth_callbacks
    root "store#home"
    get "store/home"
    get "/cart", to: "store#cart"
    post "/cart", to: "store#cart"
    get "/checkout", to: "store#checkout"
    delete "/carts", to: "carts#destroy", as: :delete_cart
    put "/minus_items", to: "minus_items#update", as: :quantity_minus
    put "/plus_items", to: "plus_items#update", as: :quantity_plus

    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registrations#new"
    end

    resources :categories, only: %i(show)
    resources :books, only: %i(index show)
    resources :carts, only: %i(index create)
    resources :orders, except: %i(edit)
    namespace :admin do
      resources :homes
      resources :categories
      resources :products
      resources :orders
      resources :accounts
      resources :books do
        member do
          delete :delete_image_attachment
        end
      end
    end
  end
end
