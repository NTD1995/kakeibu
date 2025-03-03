# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :authenticate_admin!
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # 管理者ログイン時にフラッシュメッセージを表示
  def create
    if params.dig(:admin, :email).blank? && params.dig(:admin, :password).blank?
      flash[:alert] = "Eメールまたはパスワードが空欄です"
      redirect_to new_admin_session_path
    elsif params.dig(:admin, :email).blank?
      flash[:alert] = "Eメールが空欄です"
      redirect_to new_admin_session_path
    elsif params.dig(:admin, :password).blank?
      flash[:alert] = "パスワードが空欄です"
      redirect_to new_admin_session_path
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
