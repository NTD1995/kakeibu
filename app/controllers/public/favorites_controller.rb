class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  # ログインユーザーがいいねした一覧
  def index
    @user = User.find(params[:user_id])
    @favorite_posts = Post.joins(:favorites).where(favorites: { user_id: @user.id }).page(params[:page])
  end

  # いいねをつける処理
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end
  
  # いいねを外す処理
  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end
