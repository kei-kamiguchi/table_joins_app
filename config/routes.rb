Rails.application.routes.draw do
  root 'books#index'
  resources :reviews
  resources :questions
  resources :users
  resources :books
  resources :authors
end
