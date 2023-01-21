Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'get_joke', to: 'jokes#get_joke', as: :get_joke
  root to: 'home#index'
end
