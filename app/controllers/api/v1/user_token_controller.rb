
class Api::V1::UserTokenController < ::Knock::AuthTokenController
  before_action :authenticate, except: [:create]

  def create
    user = User.find_by(email: auth_params[:email])
  
    if user && user.authenticate(auth_params[:password])
      token = auth_token(user)
      refresh_token = RefreshToken.create(user: user)
      render json: { auth_token: token, refresh_token: refresh_token.token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
  

  def refresh
    if current_user
      refresh_token = current_user.refresh_tokens.find_by(token: params[:auth][:refresh_token])
      if refresh_token && !refresh_token.expired?
        new_auth_token = auth_token(current_user)
        render json: { auth_token: new_auth_token }
      else
        render json: { error: 'Invalid refresh token' }, status: :unauthorized
      end
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def revoke
    if current_user
      refresh_token = current_user.refresh_tokens.find_by(token: params[:auth][:refresh_token])
      if refresh_token && !refresh_token.expired?
        refresh_token.destroy
        render json: { message: 'Token revoked successfully' }
      else
        render json: { error: 'Invalid refresh token' }, status: :unauthorized
      end
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private
  def auth_params
    params.require(:auth).permit(:username , :email, :password)
  end
  
end
