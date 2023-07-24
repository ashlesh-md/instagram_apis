class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_comment_creation_notification

  def send_comment_creation_notification
    NotificationService.send_notification(post.user_id, "#{user.username} liked your post!")
  end

end
