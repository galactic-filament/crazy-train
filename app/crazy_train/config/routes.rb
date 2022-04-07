Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root "default#index"
  get "/ping", to: "default#ping"
  post "/reflection", to: "default#reflection"

  resources :posts

  post "/users", to: "user#create"
  get "/user", to: "user#show"
  get "/user/admin", to: "user#admin"
  get "/user/comments", to: "user#comments"

  resources :comments
end
