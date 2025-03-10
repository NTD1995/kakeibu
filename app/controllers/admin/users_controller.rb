class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  # 管理者側

  # ユーザー一覧画面
  def index
    @users = User.all.page(params[:page]).per(10) 
  end  

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  # ユーザー編集画面
  def edit
    @user = User.find(params[:id])
  end

  # ユーザー情報更新処理
  def update
    @user = User.find(params[:id])
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

end
