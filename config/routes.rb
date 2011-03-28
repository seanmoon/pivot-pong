Pong::Application.routes.draw do
  resources :matches do
    collection do
      get 'rankings'
    end
  end
  root to: 'matches#rankings'
end
