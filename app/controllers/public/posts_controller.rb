class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  # 投稿一覧画面
  def index
    @posts = Post.all.includes(:item).page(params[:page])
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

  # 投稿詳細画面
  def show
    @post = Post.find(params[:id])
  end

  # 投稿編集画面
  def edit
    @post = Post.find(params[:id])
    @items = Item.all
  end

  # 投稿編集処理
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path, notice: "投稿が更新されました。"
    else
      @items = Item.all
      flash.now[:alert] = "投稿が更新されませんでした。"
      render :edit
    end
  end

  def destroy
  end

  private

    def post_params
    params.require(:post).permit(:created_at, :content, :category, :price, :item_id, :memo, :user_id)
  end
end
