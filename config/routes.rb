# Rails.application.routes.draw do 
#   namespace :api do
#     namespace :v1 do
#       resources :users do
#         member do
#           get 'followers' , to: 'users#followers'
#           get 'followings' , to: 'users#followings'
#           get 'notifications' , to: 'users#notifications'
#           get 'posts' , to: 'users#posts'
#           get 'likes' , to: 'users#likes'
#           get 'comments' , to: 'users#comments'
#         end
#       end
#       resources :posts , only: [:create , :show]
#       resources :comments , only: [ :create ]
#       resources :likes , only: [ :create ]
#       resources :follows , only: [:create]
#       # resources :notifications , only: []
#     end
#   end
# end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/user_token' , to: 'user_token#create'
      post '/refresh_token' ,to:  'user_token#refresh'
      post '/revoke_token' , to:  'user_token#revoke'
      get '/products' , to: 'products#get_products'
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        get :followers, on: :member
        get :followings, on: :member
        get :notifications, on: :member
        get :posts, on: :member
        get :likes, on: :member
        get :comments, on: :member
      end
    end
  end
end
