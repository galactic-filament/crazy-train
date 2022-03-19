Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root "default#index"
  get "/ping", to: "default#ping"
  post "/reflection", to: "default#reflection"
  resources :posts
end
