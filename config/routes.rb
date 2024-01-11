Rails.application.routes.draw do
  devise_for :users
  resources :movies, param: :slug
  resources :genres
  resources :movies do
    resources :reviews
    resources :favorites
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'user/:id' => 'users#show', as: :user

  # Defines the root path route ("/")
  # root "posts#index"
  get 'movies/filter/:filter' => 'movies#index', as: :filtered_movies
  root 'movies#index'
end
