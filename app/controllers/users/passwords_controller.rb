class Users::PasswordsController < Devise::PasswordsController
    include RackSessionsFix
    respond_to :json
    before_action :authenticate_user!, only: [:update_password]
  
    def create
      user = User.find_by(email: params[:user][:email])
      if user
        user.generate_otp
        UserMailer.send_otp(user).deliver_now
        render json: { message: 'OTP sent to your email.' }, status: :ok
      else
        render json: { message: 'Email not found.' }, status: :not_found
      end
    end
  
    def validate_otp
      user = User.find_by(email: params[:user][:email])
      
      if user.nil?
        render json: { message: 'Email not found.' }, status: :not_found
      elsif user.otp != params[:user][:otp]
        render json: { message: 'Invalid or expired OTP.' }, status: :unprocessable_entity
      elsif user.otp_valid?(params[:user][:otp])
        user.update(otp_verified: true)
        render json: { message: 'OTP is valid.' }, status: :ok
      else
        render json: { message: 'Check the otp again.' }, status: :unprocessable_entity
      end
    end
  
    def update
      user = User.find_by(email: params[:user][:email])
      
      if user.nil?
        render json: { message: 'Email not found.' }, status: :not_found
      elsif user.otp_verified
        if user.update(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
          user.update(otp: nil, otp_sent_at: nil, otp_verified: false)
          render json: { message: 'Password has been changed successfully.' }, status: :ok
        else
          render json: { message: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      else
        render json: { message: 'OTP has not been validated.' }, status: :unprocessable_entity
      end
    end

    def update_password
        user = current_user
        
        if user.nil?
            render json: { message: 'User not authorized'}, status: :unauthorized
        elsif user.valid_password?(params[:user][:current_password])
          if user.update(password: params[:user][:new_password], password_confirmation: params[:user][:password_confirmation])
            render json: { message: 'Password has been changed successfully.' }, status: :ok
          else
            render json: { message: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
          end
        else
          render json: { message: 'Current password is incorrect.' }, status: :unprocessable_entity
        end
      end
  end