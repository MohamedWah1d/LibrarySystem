class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :borrow_requests
  has_many :reviews

  before_create :set_default_user_type
  
  enum user_type: { user: 0, admin: 1 }

  private

  def set_default_user_type
    self.user_type ||= :user
  end
end
