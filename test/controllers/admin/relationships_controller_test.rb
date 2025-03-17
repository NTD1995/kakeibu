require "test_helper"

class Admin::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_relationships_destroy_url
    assert_response :success
  end

  test "should get followers" do
    get admin_relationships_followers_url
    assert_response :success
  end

  test "should get followeds" do
    get admin_relationships_followeds_url
    assert_response :success
  end
end
