class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = User.find(params[:user_id])
    @favorite_posts = Post.joins(:favorites).where(favorites: { user_id: @user.id }).page(params[:page]).per(1)
  end

  # いいねをつける処理
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer
  end
  
  # いいねを外す処理
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end
end
