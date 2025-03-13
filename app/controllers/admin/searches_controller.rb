class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
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
    @records = @records.page(params[:page]).per(1)
  end  

end
