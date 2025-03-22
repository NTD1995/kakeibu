require "test_helper"

class Admin::FiltersControllerTest < ActionDispatch::IntegrationTest
  test "should get filter" do
    get admin_filters_filter_url
    assert_response :success
  end
end
