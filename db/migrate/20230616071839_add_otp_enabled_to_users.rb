class AddOtpEnabledToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :otp_enabled, :boolean, default: false
  end
end
