class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  # マイページ
  def mypage
    @user = current_user
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def index
  end  

  def show
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "ユーザー情報が更新されませんでした。"
      render :edit
    end        
  end

  def destroy
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
