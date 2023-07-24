class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user!, except: [:create]
    def index
        token = request.headers['Authorization']
        response.headers['Authorization'] = token
        users = User.all
        render json: users 
    end 

    def create
        user = User.new(user_params)
        if user.valid?
            token = auth_token(user)
            refresh_token = RefreshToken.create(user: user)
            user.save
            render json: { auth_token: token, refresh_token: refresh_token.token }, status: :created
        else
            render json: user.errors , status: :unprocessable_entity
        end
    end 

    def show
        user = User.find(params[:id])
        render json: user
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: user
        else
          render json: user.errors, status: :unprocessable_entity
        end
    end 
    
    def destroy
        user = User.find(params[:id])
        if user 
           user.destroy
           render json:user
        else 
           render json: { error: 'User not found' }, status: :not_found
        end 
    end

    def followers
        followers = User.find(params[:id]).followers
        render json: followers
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
    end

    def followings
        followings = User.find(params[:id]).followings
        render json: followings
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
    end

    def notifications
        notifications = User.find(params[:id]).notifications
        render json: notifications
    end 

    def posts
        posts = User.find(params[:id]).posts
        render json: posts
    end 

    def likes
        likes = User.find(params[:id]).likes
        render json: likes
    end 

    def comments
        comments = User.find(params[:id]).comments
        render json: comments
    end 

    private 

    def user_params
        params.require(:user).permit(:username , :email , :password_digest)
    end 
end
