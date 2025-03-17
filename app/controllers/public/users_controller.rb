class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:mypage, :index, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # マイページ
  def mypage
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  # ユーザー一覧画面
  def index
    @users = User.all.page(params[:page])    
  end  

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  # ユーザー編集画面
  def edit
  end

  # ユーザー情報更新処理
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "ユーザー情報が更新されませんでした。"
      render :edit
    end        
  end

  # ユーザー退会処理
  def destroy
    @user.update(is_active: false)
    sign_out(@user)
    redirect_to new_user_registration_path, notice: "退会しました。"
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :introduction, :email)
  end

  # 各アクション内で現在のユーザー情報を使用
  def set_user
    @user = current_user
  end

  # 現在ログインしているユーザーがアクセスしようとするユーザーでなければ、編集や更新や削除ができないように制限
  def authorize_user!
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to mypage_path, alert: "他のユーザーを編集・更新・削除する権限がありません。"
    end
  end
end
