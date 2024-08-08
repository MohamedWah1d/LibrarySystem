class AddEmailVerificationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email_verification_otp, :string
    add_column :users, :email_verification_otp_sent_at, :datetime
  end
end
