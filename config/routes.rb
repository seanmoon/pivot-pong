Pong::Application.routes.draw do
  resources :matches do
    collection do
      get 'rankings'
      get 'players'
    end
  end
  root to: 'matches#rankings'
end
