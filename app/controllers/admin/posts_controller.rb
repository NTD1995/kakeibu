class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # 投稿一覧画面
  def index
    @posts = Post.all.includes(:item).page(params[:page])
  end

  # 新規投稿画面
  def new
    @post = Post.new
    @items = Item.all
  end

  # 新規投稿処理
  def create
    @post = Post.new(post_params)
    @post.user_id = current_admin.id
    if @post.save
      redirect_to admin_path, notice: "投稿に成功しました。"
    else
      @items = Item.all
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end    
  end

  # 投稿詳細画面
  def show
  end

  # 投稿編集画面
  def edit
    @items = Item.all
  end

  # 投稿編集処理
  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "投稿が更新されました。"
    else
      @items = Item.all
      flash.now[:alert] = "投稿が更新されませんでした。"
      render :edit
    end
  end

  # 投稿削除処理
  def destroy
    @post.destroy
    redirect_to admin_path, alert: "投稿を削除しました。"    
  end

  private

    # ユーザーから送信されたデータのうち許可した項目のみを取得
    def post_params
      params.require(:post).permit(:created_at, :content, :category, :price, :item_id, :memo, :user_id)
    end

    # 各アクション内で投稿情報を使用
    def set_post
      @post = Post.find(params[:id])
    end
end
