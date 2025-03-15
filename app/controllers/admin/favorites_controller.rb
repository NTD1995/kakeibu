class Admin::FavoritesController < ApplicationController
  before_action :authenticate_admin!
  
  # いいねされている投稿一覧
  def index
    @favorites = Favorite.includes(:user, :post).page(params[:page])
  end  

  # いいねをつける処理
  def create
    post = Post.find(params[:post_id])
    if params[:user_id].present?
    #  ユーザーがいいねをつける 
     favorite = Favorite.new(user_id: params[:user_id], post_id: post.id)
     favorite.save
    else 
    #  管理者がいいねをつける 
     favorite = Favorite.new(admin_id: current_admin.id, post_id: post.id)
     favorite.save
    end
    @post = post
  end
  
  # いいねを外す処理
  def destroy
    if params[:user_id].present?
      #  ユーザーがいいねを外す
      favorite = Favorite.find_by(post_id: params[:id],user_id: params[:user_id])
      favorite.destroy
    else
      #  管理者がいいねを外す
      favorite = Favorite.find_by(post_id: params[:id],admin_id: current_admin.id)
      favorite.destroy
    end
    @post = favorite.post
  end

end
