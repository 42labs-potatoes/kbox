Rails.application.routes.draw do
  root to: "home#index"
  get 'home/search', to: 'home#search'
  get 'songs/search', to: 'songs#search'
  resources :songs



  resources :groups do
    resource :playlist do
      resources :songs do
        collection { get :events }
      end
    end
  end


end
