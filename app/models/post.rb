class Post < ApplicationRecord
  after_create :send_post_creation_notification
  belongs_to :user
  has_many :comments
  has_many :likes

  def send_post_creation_notification
    NotificationService.send_notification(user_id, "Your post was created successfully!")
  end
  
end