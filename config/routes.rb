Rails.application.routes.draw do
  devise_for :users
  resources :lists, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:create]
  end
  resources :bookmarks, only: [:destroy]
  root to: "lists#index"
end
