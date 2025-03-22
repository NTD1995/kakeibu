class Admin::MessagesController < ApplicationController
  before_action :authenticate_admin!

  # メッセージ削除処理
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to admin_room_path(@message.room)
  end
end
