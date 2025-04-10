class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_non_related, only: [:show]


  # ルーム新規作成処理
  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room)
  end

  # ルーム詳細画面
  def show
    @user = current_user
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @other_user = @entries.find { |entry| entry.user != current_user }.user
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def reject_non_related
      room = Room.find(params[:id])
      user = room.entries.where.not(user_id: current_user.id).first.user
      unless (current_user.following?(user)) && (user.following?(current_user))
        redirect_to posts_path
      end
    end  
end
