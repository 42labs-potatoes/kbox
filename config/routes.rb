Rails.application.routes.draw do
  root to: "home#index"
  get 'home/search', to: 'home#search'
  get 'songs/search', to: 'songs#search'
  resources :songs do
    resource :votes, only: [:create]
  end



  resources :groups do
    resource :playlist do
      collection { post :next_song }
      resources :songs do
        collection { get :events }
      end
    end
  end


end
