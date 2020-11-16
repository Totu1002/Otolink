require 'test_helper'

class Users::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_notifications_index_url
    assert_response :success
  end

end
