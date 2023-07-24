class Api::V1::NotificationsController < ApplicationController
  def index
    notifications = Notification.all 
    render json: notifications
  end

  def create
  end

  def show
    notification = Notification.find(params[:id])
    render json: notification
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Notification not found' }, status: :not_found
  end

  def update
  end

  def destroy
  end
end
