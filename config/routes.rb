Rails.application.routes.draw do
  resources :cuisines, only: [:index]
  resources :restaurants, only: [:index, :show, :create] do
    resources :reviews, only: [:create]
  end
end
