require 'test_helper'

class Users::RecruitsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_recruits_new_url
    assert_response :success
  end

  test "should get show" do
    get users_recruits_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_recruits_edit_url
    assert_response :success
  end

end
