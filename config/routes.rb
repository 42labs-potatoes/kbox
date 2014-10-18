Rails.application.routes.draw do
  root to: "home#index"
  get 'home/search', to: 'home#search'
  resources :songs

  resources :playlists

  resources :groups do
    collection { get :events }
  end


end
