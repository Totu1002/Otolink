class Users::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    #DM通知機能
    @room=@message.room
    if @message.save
      @roommembernotme=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid=@roommembernotme.find_by(room_id: @room.id)
      notification = current_user.active_notifications.new(
        room_id: @room.id,
        message_id: @message.id,
        visited_id: @theid.user_id,
        visitor_id: current_user.id,
        action: "dm"
        )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save

      if notification.valid?
        redirect_to room_path(@message.room)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    redirect_back(fallback_location: room_path)
  end

  private

    def message_params
      params.require(:message).permit(:room_id, :body)
    end
end