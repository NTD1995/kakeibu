# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # ログイン時にフラッシュメッセージを表示
  def create
    if params.dig(:user, :email).blank? && params.dig(:user, :password).blank?
      flash[:alert] = "Eメールまたはパスワードが空欄です"
      redirect_to new_user_session_path
    elsif params.dig(:user, :email).blank?
      flash[:alert] = "Eメールが空欄です"
      redirect_to new_user_session_path
    elsif params.dig(:user, :password).blank?
      flash[:alert] = "パスワードが空欄です"
      redirect_to new_user_session_path
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
