class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  # ユーザー一覧画面
  def index
    @users = User.all.page(params[:page]).per(10) 
  end  

  # ユーザー詳細画面
  def show
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  # ユーザー編集画面
  def edit
  end

  # ユーザー情報更新処理
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "ユーザー情報が更新されませんでした。"
      render :edit
    end        
  end

    private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :is_active, :image)
  end

  # 各アクション内でユーザー情報を使用
  def set_user
    @user = User.find(params[:id])
  end

end
