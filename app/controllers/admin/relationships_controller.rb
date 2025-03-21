class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  
  # フォローする処理
  def create
    user = User.find_by(id: params[:user_id]) # フォロー元
    followed = User.find_by(id: params[:followed_id]) # フォロー先
    if user.nil? || followed.nil?
      flash[:alert] = "フォローするユーザーを選択してください。"
      redirect_to request.referer
    return
    end
    if Relationship.exists?(follower_id: user.id, followed_id: followed.id)
    else
      Relationship.create(follower_id: user.id, followed_id: followed.id)
    end
    redirect_to request.referer  
  end

  # フォローを外す処理
  def destroy
    Relationship.find(params[:id]).destroy
    redirect_to  request.referer
  end
  
end

