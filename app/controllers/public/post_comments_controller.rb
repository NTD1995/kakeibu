class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  # コメント投稿処理
  def create
    post_comment = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = post_comment.id
    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
    else
      flash.now[:alert] = "コメントの投稿に失敗しました。"
    end
  end

  # コメント削除処理
  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
    flash.now[:alert] = "コメントを削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
