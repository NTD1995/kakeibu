class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  # 新規投稿画面
  def new
    @post = Post.new(user_id: current_user.id)
    @items = Item.all
  end

  # 新規投稿処理
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    if @post.save
      redirect_to posts_path(@post), notice: "投稿に成功しました"
    else
      @items = Item.all
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end    
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def post_params
    params.require(:post).permit(:created_at, :content, :category, :price, :item_id, :memo)
  end
end
