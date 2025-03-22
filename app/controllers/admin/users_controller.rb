class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  # ユーザー一覧画面
  def index
    @users = User.all.page(params[:page]).per(10)
    @host = User.find(params[:host_id]) if params[:host_id].present?
  end  

  # ユーザー詳細画面
  def show
    case params[:sort]
    # いいね数多い順
    when 'favorites' 
      @user_posts = Post.left_joins(:favorites)
                .group(:id)
                .order('COUNT(favorites.id) DESC', 'created_at DESC')
                .page(params[:page])
    # コメント数多い順            
    when 'comments'
      @user_posts = Post.left_joins(:post_comments)
                .group(:id)
                .order(('COUNT(post_comments.id) DESC, created_at DESC'))
                .page(params[:page])               
    # 金額の高い順
    when 'prices'
      post_income = Post.includes(:item).where(category: "income").order("price DESC")
      post_expense = Post.includes(:item).where(category: "expense").order("price ASC")
      @user_posts = Kaminari.paginate_array(post_income + post_expense).page(params[:page])
    # 日付の新しい順
    when 'date'
      @user_posts = Post
                  .order(created_at: :desc)
                  .page(params[:page])                                              
    # デフォルト: 古いID順                  
    else
      @user_posts = User.find(params[:id]).posts.order(id: :asc).page(params[:page])
    end
    case params[:sort_other]
    # いいね数多い順
    when 'favorites' 
      @posts = Post.where.not(user: @user).left_joins(:favorites)
                .group(:id)
                .order('COUNT(favorites.id) DESC', 'created_at DESC')
                .page(params[:other_page])                
    # コメント数多い順            
    when 'comments'
      @posts = Post.where.not(user: @user).left_joins(:post_comments)
                .group(:id)
                .order(('COUNT(post_comments.id) DESC, created_at DESC'))
                .page(params[:other_page])                
    # 金額の高い順
    when 'prices'
      post_income = Post.where.not(user: @user).includes(:item).where(category: "income").order("price DESC")
      post_expense = Post.where.not(user: @user).includes(:item).where(category: "expense").order("price ASC")
      @posts = Kaminari.paginate_array(post_income + post_expense).page(params[:other_page])      
    # 日付の新しい順
    when 'date'
      @posts = Post
                  .where.not(user: @user)
                  .order(created_at: :desc)
                  .page(params[:other_page])                                                
    # デフォルト: 古いID順                  
    else
      @posts = Post.where.not(user: @user).order(id: :asc).page(params[:other_page])     
    end
  end

  # ユーザー編集画面
  def edit
  end

  # ユーザー情報更新処理
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "ユーザー情報が更新されませんでした。"
      render :edit
    end        
  end

  # フォロー一覧画面
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
  end
  
  # フォロワー一覧画面
  def followeds
    @user = User.find(params[:id])
    @users = @user.followeds.page(params[:page])
  end

  # 投稿一覧の収支金額の１ヶ月間の表示
  def get_month_data
    user = User.find(params[:user_id])
    date = params[:date]
    income = user.posts.where(created_at: date, category: "income").sum(:price)
    expense = user.posts.where(created_at: date, category: "expense").sum(:price)
    balance = income - expense
    render json: { income: income, expense: expense, balance: balance }
  end

    private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :is_active, :image)
  end

  # 各アクション内でユーザー情報を使用
  def set_user
    @user = User.find(params[:id])
  end

end
