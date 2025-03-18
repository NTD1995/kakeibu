class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  # コメント削除処理
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end
end
