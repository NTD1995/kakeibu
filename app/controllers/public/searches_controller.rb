class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
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
    @records = @records.page(params[:page])
  end   

end
