require 'test_helper'

class Admins::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admins_homes_top_url
    assert_response :success
  end

  test "should get about" do
    get admins_homes_about_url
    assert_response :success
  end

end
