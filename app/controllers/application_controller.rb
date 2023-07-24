class ApplicationController < ActionController::API
  include Knock::Authenticable

  private

  def current_user
    @current_user ||= if token_payload
                        User.find_by(id: token_payload['sub'])
                      end
  end

  def token_payload
    auth_token = token_from_request_headers

    return unless auth_token

    Knock::AuthToken.new(token: auth_token).payload
  rescue JWT::VerificationError, JWT::DecodeError
    nil
  end
  
  def auth_token(user)
    secret_key = Rails.application.credentials.secret_key_base
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, secret_key, 'HS256')
  end
end
  