Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships
  end
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  get '/api/posts', to: 'api#show_posts'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/posts/:post_id/comments', to: 'api#show_comments'
end
