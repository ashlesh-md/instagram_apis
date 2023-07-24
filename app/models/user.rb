class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments
  has_many :likes
  has_many :followings, foreign_key: :follower_id, class_name: "Follow"
  has_many :followers, foreign_key: :followed_id, class_name: "Follow"
  has_many :notifications, foreign_key: :user_id, class_name: "Notification"

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true, length: { minimum: 6 }


  def self.from_token_payload(payload)
    find(payload["sub"])
  end
end

