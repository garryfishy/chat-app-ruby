Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'api/test', to: 'application#test'
  post 'api/login', to: 'application#login'
  post 'api/send/:id', to: 'application#sendMessage'
  # Defines the root path route ("/")
  # root "articles#index"
end
