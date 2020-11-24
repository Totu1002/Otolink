class Users::NotificationsController < ApplicationController
  #Rev2.0にて実装するが本機能は現状使用しない
  def index
    #通知機能用
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
