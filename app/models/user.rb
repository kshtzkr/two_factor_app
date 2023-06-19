class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: ENV['OTP_SECRET_ENCRYPTION_KEY']

  def generate_otp
    self.otp_secret_key = rand(100_000..999_999).to_s
    save
  end

  def disable_otp
    self.otp_secret_key = nil
  end

  def otp_enabled?
    otp_secret_key.present?
  end

  private

  def generate_otp_secret_key
    enable_otp if otp_enabled?
  end

  def should_generate_otp_secret_key?
    otp_enabled? && otp_secret_key.blank?
  end
end
