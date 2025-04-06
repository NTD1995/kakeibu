class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:mypage, :index, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]

  # マイページ
  def mypage
    @user_posts = @user.posts.includes(:item, :post_comments)

    # 収入と支出と収支の合計を計算
    @income_total = @user_posts.where(category: "income").sum(:price)
    @expense_total = @user_posts.where(category: "expense").sum(:price)
    @balance_total = @income_total - @expense_total

    case params[:sort]
    # いいね数多い順
    when 'favorites' 
      @user_posts = @user_posts.left_joins(:favorites)
                 .group(:id)
                 .includes(:item, :post_comments)
                 .order('COUNT(favorites.id) DESC', 'created_at DESC')
                 .page(params[:page])
    # コメント数多い順            
    when 'comments'
      @user_posts = @user_posts.left_joins(:post_comments)
                 .group(:id)
                 .includes(:item, :post_comments)
                 .order(('COUNT(post_comments.id) DESC, created_at DESC'))
                 .page(params[:page])
    # 金額の高い順
    when 'prices'
      post_income = @user_posts.includes(:item, :post_comments).where(category: "income").order("price DESC")
      post_expense = @user_posts.includes(:item, :post_comments).where(category: "expense").order("price ASC")
      @user_posts = Kaminari.paginate_array(post_income + post_expense).page(params[:page])                       
    # デフォルト: 新しい日付順                  
    else 
      @user_posts = @user_posts.includes(:item, :post_comments)
                   .order(created_at: :desc)
                   .page(params[:page])                
    end  
  end

  # ユーザー一覧画面
  def index
    @users = User.all.page(params[:page])    
  end  

  # ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.includes(:item, :post_comments)
    case params[:sort]
    # いいね数多い順
    when 'favorites' 
      @user_posts = @user_posts.left_joins(:favorites)
                 .group(:id)
                 .includes(:item, :post_comments)
                 .order('COUNT(favorites.id) DESC', 'created_at DESC')
                 .page(params[:page])
    # コメント数多い順            
    when 'comments'
      @user_posts = @user_posts.left_joins(:post_comments)
                 .group(:id)
                 .includes(:item, :post_comments)
                 .order(('COUNT(post_comments.id) DESC, created_at DESC'))
                 .page(params[:page])
    # 金額の高い順
    when 'prices'
      post_income = @user_posts.includes(:item, :post_comments).where(category: "income").order("price DESC")
      post_expense = @user_posts.includes(:item, :post_comments).where(category: "expense").order("price ASC")
      @user_posts = Kaminari.paginate_array(post_income + post_expense).page(params[:page])                       
    # デフォルト: 新しい日付順                  
    else 
      @user_posts = @user_posts.includes(:item, :post_comments)
                   .order(created_at: :desc)
                   .page(params[:page])                
    end
    
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu| 
        @userEntry.each do |u| 
          if cu.room_id == u.room_id 
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end    
  end

  # ユーザー編集画面
  def edit
  end

  # ユーザー情報更新処理
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "ユーザー情報が更新されませんでした。"
      render :edit
    end        
  end

  # ユーザー退会処理
  def destroy
    @user.update(is_active: false)
    sign_out(@user)
    redirect_to new_user_registration_path, notice: "退会しました。"
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :introduction, :email)
  end

  # 各アクション内で現在のユーザー情報を使用
  def set_user
    @user = current_user
  end

  # 現在ログインしているユーザーがアクセスしようとするユーザーでなければ、編集や更新や削除ができないように制限
  def authorize_user!
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to mypage_path, alert: "他のユーザーを編集・更新・削除する権限がありません。"
    end
  end

  # ゲストユーザーがプロフィールを編集できないようにする
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
