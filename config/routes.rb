Rails.application.routes.draw do
  root to: 'homes#top'
  get "about" => 'homes#about'
  get "search" => 'searches#search'
  get 'ranks/index'
  get '/dive/hashtag/:name' => 'dives#hashtag'

  devise_for :users, module: "users"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dives do
    resources :dive_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get "quit"
      patch "out"
    end
  end

  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :notifications, only: [:index]
  resources :ranks, only: [:index]
  resources :bookmarks, only: [:index]
end
