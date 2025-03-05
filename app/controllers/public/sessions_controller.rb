# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]  

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

private

  # ユーザーステータスがアクティブであるかを判断するメソッド
  def user_state
    # 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?
    # 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
    # アクティブでないユーザーに対する処理
    unless user.active?
      flash[:alert] = "あなたは退会済みです。再度新規登録をお願いします。"
      redirect_to new_user_registration_path
      return
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
