Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'api/login', to: 'application#login'
  post 'api/send/:id', to: 'application#sendMessage'
  get 'api/messages/:id', to: 'application#getChat'
  get 'api/my-messages', to: 'application#getMine'
  # Defines the root path route ("/")
  # root "articles#index"
end
