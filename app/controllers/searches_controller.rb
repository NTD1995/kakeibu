class SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!
  
  # 検索処理
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    if @model  == "user"
      @records = User.search_for(@content, @method)
    else
      @records = Post.search_for(@content, @method)
    end
    @records = @records.page(params[:page]).per(10)
  end  

  private

  # ユーザーまたは管理者がログインしていることを確認
  def authenticate_user_or_admin!
    unless user_signed_in? || admin_signed_in?
      redirect_to new_user_session_path, alert: "検索を利用するにはログインが必要です"
    end
  end
end
