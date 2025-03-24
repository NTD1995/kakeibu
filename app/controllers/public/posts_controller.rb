class Public::PostsController < ApplicationController
  # before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # 投稿一覧画面
  def index
    case params[:sort]
    # いいね数多い順
    when 'favorites' 
      @posts = Post.left_joins(:favorites)
                 .group(:id)
                 .includes(:item, :post_comments)
                 .order('COUNT(favorites.id) DESC', 'created_at DESC')
                 .page(params[:page])
    # コメント数多い順            
    when 'comments'
      @posts = Post.left_joins(:post_comments)
                 .group(:id)
                 .includes(:item, :post_comments)
                 .order(('COUNT(post_comments.id) DESC, created_at DESC'))
                 .page(params[:page])
    # 金額の高い順
    when 'prices'
      post_income = Post.includes(:item, :post_comments).where(category: "income").order("price DESC")
      post_expense = Post.includes(:item, :post_comments).where(category: "expense").order("price ASC")
      @posts = Kaminari.paginate_array(post_income + post_expense).page(params[:page])                       
    # デフォルト: 新しい日付順                  
    else 
      @posts = Post.includes(:item, :post_comments)
                   .order(created_at: :desc)
                   .page(params[:page])                
    end
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
      redirect_to posts_path(@post), notice: "投稿に成功しました。"
    else
      @items = Item.all
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end    
  end

  # 投稿詳細画面
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
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

  # 投稿削除処理
  def destroy
   @post = Post.find(params[:id])
   @post.destroy
   redirect_to posts_path, alert: "投稿を削除しました。"    
  end

  # 投稿一覧の収支金額の１ヶ月間の表示
  def get_month_data
    date = params[:date]
    income = current_user.posts.where(created_at: date.in_time_zone.all_day, category: "income").sum(:price)
    expense = current_user.posts.where(created_at: date.in_time_zone.all_day, category: "expense").sum(:price)
    balance = income - expense
    render json: { income: income, expense: expense, balance: balance }
  end


  private

    # ユーザーから送信されたデータのうち許可した項目のみを取得
    def post_params
      params.require(:post).permit(:created_at, :content, :category, :price, :item_id, :memo, :user_id).tap do |post_params|
       post_params[:category] = post_params[:category].to_sym if post_params[:category].present?
     end
    end 

    # 各アクション内で投稿情報を使用
    def set_post
      @post = Post.find(params[:id])
    end
    
    # 現在ログインしているユーザーがその投稿の所有者でなければ、編集や更新や削除ができないように制限
    def authorize_user!
      unless @post.user == current_user
        redirect_to posts_path, alert: "この投稿を編集・更新・削除する権限がありません。"
      end
    end
end
