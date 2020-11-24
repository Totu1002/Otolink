module Users::NotificationsHelper
  #未読を検索するメソッド
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
