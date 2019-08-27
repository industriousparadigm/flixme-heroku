Rails.application.routes.draw do
  # auth routes
  post 'signin', to: 'users#signin'
  get '/validate', to: 'users#validate'

  # CRUD routes
  resources :movies, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create, :update]
  resources :genres, only: [:index]

  # custom routes
  get '/movie_search', to: 'movies#search'
  post '/rate_movie', to: 'users#rate_movie'
  post '/forget_movie', to: 'users#forget_movie'
  post '/add_friend', to: 'users#add_friend'
  post '/delete_friend', to: 'users#delete_friend'

end
