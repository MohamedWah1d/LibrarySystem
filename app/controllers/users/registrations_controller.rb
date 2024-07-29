class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    token = request.env['warden-jwt_auth.token']
    if resource.persisted?
      render json: {
        message: 'Signed up successfully.',
        data: {
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
        extra: {
          access_token: token
        } 
      }
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
