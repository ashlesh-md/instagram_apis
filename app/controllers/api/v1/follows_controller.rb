class Api::V1::FollowsController < ApplicationController
  def index
    follows = Follow.all 
    render json: follows
  end

  def create
    follow = Follow.new(follow_params)
    if follow.save
      render json: follow , status: :created
    else
      render json: follow.errors , status: :unprocessable_entity
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def follow_params
    params.require(:follow).permit(:follower_id , :followed_id)
  end 
end
