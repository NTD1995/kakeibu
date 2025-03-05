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
  end

  def update
  end

  def destroy
  end

  def followers
  end

  def followeds
  end
end
