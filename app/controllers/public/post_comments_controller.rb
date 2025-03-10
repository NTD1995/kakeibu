class Public::PostCommentsController < ApplicationController
  def create
    post_comment = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post_comment.id
    comment.save
    redirect_to post_path(post_comment)
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.find_by(post_id: post.id)
    comment.destroy
    redirect_to post_path(post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
