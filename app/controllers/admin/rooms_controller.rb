class Admin::RoomsController < ApplicationController
  before_action :authenticate_admin!

  # ルーム一覧画面
  def index
    @rooms = Room.all
    @entries = Entry.includes(:user).all
  end

  # ルーム詳細画面
  def show
    @room = Room.find_by(id: params[:id])
    @messages = @room.messages.includes(:user)
    @message = Message.new
    @entries = @room.entries
  end

  # ルーム削除処理
  def destroy
    @room = Room.find_by(id: params[:id])
    if @room
      @room.destroy
      redirect_to admin_rooms_path, alert: 'ルームを削除しました。'
    else
      redirect_to admin_rooms_path, alert: 'ルームが見つかりません。'
    end
  end  

end
