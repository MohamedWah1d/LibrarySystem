class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
  token = request.env['warden-jwt_auth.token']
    render json: {
        message: 'Logged in successfully.',
        data: {
        user: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }, 
        extra: {
          access_token: token
        }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find_by(id: jwt_payload['sub'], jti: jwt_payload['jti'])
    end
    
    if current_user
      render json: {
        message: 'Logged out successfully.',
        data:{}
      }, status: :ok
    else
      render json: {
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
