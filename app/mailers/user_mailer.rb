class UserMailer < ApplicationMailer
    default from: 'no-reply@example.com'
  
    def send_otp(user)
      @user = user
      mail(to: @user.email, subject: 'Your OTP code for password resetting') do |format|
        format.text { render plain: "Hello, #{@user.name}, your OTP code is: #{@user.otp}\nThis code is valid for 15 minutes." }
      end
    end

    def send_email_otp(user)
      @user = user
      mail(to: @user.email, subject: 'Your OTP code for email verification') do |format|
        format.text { render plain: "Hello, #{@user.name}, your OTP code is: #{@user.email_verification_otp}\nThis code is valid for 15 minutes." }
      end
    end
  end