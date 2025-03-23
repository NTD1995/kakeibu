class Public::MessagesController < ApplicationController
  before_action :authenticate_user!

  # メッセージ新規投稿処理
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @message.user_id = current_user.id
      if @message.save
        flash.now[:notice] = "メッセージの投稿に成功しました。"
        render :create
      else
        flash.now[:alert] = "メッセージの投稿に失敗しました。"
        render :validater, status: :unprocessable_entity
      end
    else
      render :validater, status: :unprocessable_entity 
    end
  end

  private

    def message_params
      params.require(:message).permit(:user_id, :room_id, :content)
    end

end
