require "test_helper"

class Admin::FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_favorites_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_favorites_destroy_url
    assert_response :success
  end
end
