class RefreshToken < ApplicationRecord
    belongs_to :user
  
    before_create :generate_token
    before_create :set_expiration
  
      # Generate a token using the HS256 algorithm
    def generate_token
      payload = { user_id: self.user_id, exp: 24.hours.from_now.to_i }
      secret_key = Rails.application.credentials.secret_key_base
      self.token = JWT.encode(payload, secret_key, 'HS256')
    end
    def set_expiration
      self.expires_at = 7.days.from_now
    end
  end
  