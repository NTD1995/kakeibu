class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  # マイページ
  def mypage
    @user = current_user
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  # ユーザー一覧画面
  def index
    @user = current_user
    @users = User.all.page(params[:page])    
  end  

  # ユーザー詳細画面
  def show
    @user = current_user
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  # ユーザー編集画面
  def edit
    @user = current_user
  end

  # ユーザー情報更新処理
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "ユーザー情報が更新されませんでした。"
      render :edit
    end        
  end

  # ユーザー退会処理
  def destroy
    @user = current_user
    @user.update(is_active: false)
    sign_out(@user)
    redirect_to new_user_registration_path, notice: "退会しました。"
  end

  def followers
  end

  def followeds
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :introduction, :email)
  end

end
