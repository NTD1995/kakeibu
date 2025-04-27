class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  # フォローする処理
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  # フォロー外す処理
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
  
  # フォロワー一覧画面
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page])
  end
  
  # フォロー一覧画面
  def followeds
    @user = User.find(params[:user_id])
    @users = @user.followeds.page(params[:page])
  end
end
