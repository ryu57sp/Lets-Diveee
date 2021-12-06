Rails.application.routes.draw do
  root to: 'homes#top'
  get "about" => 'homes#about'
  devise_for :users, module: "users"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dives do
    resources :dive_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get "quit"
      patch "out"
    end
  end
end
