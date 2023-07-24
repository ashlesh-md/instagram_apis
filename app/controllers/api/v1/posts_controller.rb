class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all 
    render json: posts
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post , status: :created
    else
      render json: post.errors , status: :unprocessable_entity
    end
  end

  def show
    post = Post.find(params[:id])
    render json: post
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post 
      post.destroy
      render json:post
    else 
      render json: { error: 'Post not found' }, status: :not_found
    end 
  end

  private

  def post_params
    params.require(:post).permit(:caption , :image , :user_id)
  end
end
