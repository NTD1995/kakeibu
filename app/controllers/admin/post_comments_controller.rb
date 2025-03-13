class Admin::PostCommentsController < ApplicationController
  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path
  end
end
