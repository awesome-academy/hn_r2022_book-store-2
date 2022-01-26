Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "admin_pages#home"
    get "admin_pages/home"
    get "/category", to: "admin_pages#category"
    get "/product", to: "admin_pages#product"
    get "/order", to: "admin_pages#order"
    get "/account", to: "admin_pages#account"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
  end
end
