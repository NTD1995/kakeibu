class Public::FiltersController < ApplicationController
  before_action :authenticate_user!

  def filter
    @posts = Post.all.order(created_at: :desc)
    @items = Item.all  
    if params[:item_id].present?
      @posts = @posts.where(item_id: params[:item_id])
    end
    @posts = @posts.page(params[:page])
  end
end
