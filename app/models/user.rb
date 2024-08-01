class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :borrow_requests
  has_many :reviews

  before_create :set_default_user_type
  
  enum user_type: { user: 0, admin: 1 }

  def generate_otp
    self.otp = rand(100000..999999).to_s
    self.otp_sent_at = Time.current
    self.otp_verified = false
    self.save!
  end

  def otp_valid?(submitted_otp)
    otp == submitted_otp && otp_sent_at > 15.minutes.ago
  end

  private

  def set_default_user_type
    self.user_type ||= :user
  end
end
