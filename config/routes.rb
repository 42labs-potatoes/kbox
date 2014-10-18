Rails.application.routes.draw do
  root to: "home#index"
  get 'home/search', to: 'home#search'
  get 'songs/search', to: 'songs#search'
  resources :songs



  resources :groups do
    collection { get :events }
    resources :playlists do
      resources :songs
    end
  end


end
