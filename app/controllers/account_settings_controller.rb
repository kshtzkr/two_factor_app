class AccountSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_2fa_enabled, only: [:edit, :update]

  def index
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "Account settings updated successfully."
      redirect_to edit_account_settings_path
    else
      flash.now[:alert] = "Invalid verification code."
      redirect_to edit_account_settings_path, alert: flash[:alert]
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :otp_enabled)
  end

  def check_2fa_enabled
    if current_user.otp_enabled
      unless params[:otp_secret_key] && valid_otp_secret_key?(params[:otp_secret_key])
        return true
      end
    end
    return false
  end

  def valid_otp_secret_key?(otp_secret_key)
    current_user.otp_secret_key == otp_secret_key
  end
end
