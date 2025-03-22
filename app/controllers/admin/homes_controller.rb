class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
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
    # 日付の新しい順
    when 'date'
      @posts = Post.includes(:item, :post_comments)
                   .order(created_at: :desc)
                   .page(params[:page])                             
    # デフォルト: 古いID順                  
    else 
      @posts = Post.includes(:item, :post_comments)
                   .order(id: :asc)
                   .page(params[:page])                
    end 
  end
end
