Rails.application.routes.draw do
  devise_for :users 
  resources :users do
    resources :jokes
  end
  get 'my_jokes', to: 'jokes#my_jokes', as: :my_jokes
  root to: 'home#index'
end
