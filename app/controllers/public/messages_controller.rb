class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room
  before_action :set_message, only: [:destroy]

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

  # メッセージ削除処理
  def destroy
    if @message.user == current_user
      @message.destroy
      flash.now[:alert] = "メッセージを削除しました。"
    end  
  end

  private

    def message_params
      params.require(:message).permit(:user_id, :room_id, :content)
    end

    def set_room
      @room = Room.find(params[:room_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to rooms_path, alert: '指定されたルームが見つかりません。'
    end

    def set_message
      @message = @room.messages.find_by(id: params[:id])
      if @message.nil?
        redirect_to room_path(@room), alert: '指定されたメッセージが見つかりません。'
      end
    end

end
