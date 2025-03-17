class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  
  # フォローする処理
  def create
    host = User.find(params[:host_id])
    user = User.find(params[:user_id])
    if Relationship.exists?(follower_id: host.id, followed_id: user.id)
      flash.now[:alert] = "既にフォローしています。"
      redirect_to request.referer
    end
  end


  # フォローを外す処理
  def destroy
    Relationship.find(params[:id]).destroy
    redirect_to  request.referer
  end
  
end

