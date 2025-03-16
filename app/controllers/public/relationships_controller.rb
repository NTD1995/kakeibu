class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to  request.referer
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page])
  end
  
  def followeds
    user = User.find(params[:user_id])
    @users = user.followeds.page(params[:page])
  end
end
