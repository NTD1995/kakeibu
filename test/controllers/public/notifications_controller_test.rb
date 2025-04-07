require "test_helper"

class Public::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get public_notifications_update_url
    assert_response :success
  end
end
