Rails.application.routes.draw do
  root to:"homes#top"
  devise_for :users

  get '/home/about' => 'homes#about', as: 'about'

  resources :books,only: [:create,:index,:show,:edit,:destroy]
  resources :users,only: [:show,:index,:edit]
  patch 'users/:id' => 'users#update', as: 'update_user'
  patch 'books/:id' => 'books#update', as: 'update_book'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
