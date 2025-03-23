class Admin::FiltersController < ApplicationController
  before_action :authenticate_admin!

  def filter
    @posts = Post.all
    @items = Item.all  
    if params[:item_id].present?
      @posts = @posts.where(item_id: params[:item_id])
    end
    @posts = @posts.page(params[:page])
  end  
end
