Rails.application.routes.draw do
  root to:"homes#top"
  devise_for :users

  get '/home/about' => 'homes#about', as: 'about'
  # 検索機能
  get "search" => "searches#search"
  get "search_tag" => "books#search_tag"

  resources :books,only: [:create,:index,:show,:edit,:destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # usersの中にフォローをネストさせる
  resources :users,only: [:show,:index,:edit] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  patch 'users/:id' => 'users#update', as: 'update_user'
  patch 'books/:id' => 'books#update', as: 'update_book'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
