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
    @user_posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
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
