Rails.application.routes.draw do
  root to: "home#index"

  resources :songs

  resources :playlists

  resources :groups


end
