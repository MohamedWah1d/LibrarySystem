class UserMailer < ApplicationMailer
    default from: 'no-reply@example.com'
  
    def send_otp(user)
      @user = user
      mail(to: @user.email, subject: 'Your OTP code for password resetting') do |format|
        format.text { render plain: "Your OTP code is: #{@user.otp}\nThis code is valid for 15 minutes." }
      end
    end
  end