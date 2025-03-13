class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.all.includes(:item).page(params[:page])
  end
end
