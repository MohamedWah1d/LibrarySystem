class Users::EmailVerificationController < ApplicationController
    before_action :authenticate_user!

    def send_email_otp
      current_user.generate_email_otp
      UserMailer.send_email_otp(current_user).deliver_now
      render json: { message: 'OTP sent to your email.' }, status: :ok
    end 

    def verify_email_otp
        token = request.headers['Authorization']&.split(' ')&.last
        if current_user.email_verification_otp != params[:user][:email_verification_otp]
          render json: { message: 'Invalid or expired OTP.' }, status: :unprocessable_entity
        elsif current_user.email_otp_valid?(params[:user][:email_verification_otp])
          current_user.update!(email_verified_at: Time.current)
          render json: {
            message: 'Email verified successfully.',
            data: {
              user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
              extra: {
                access_token: token
              }
            }
          }, status: :ok
        else
          render json: { message: 'Invalid or expired OTP.' }, status: :unprocessable_entity
        end
      end
end
