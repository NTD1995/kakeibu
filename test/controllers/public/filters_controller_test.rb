require "test_helper"

class Public::FiltersControllerTest < ActionDispatch::IntegrationTest
  test "should get filter" do
    get public_filters_filter_url
    assert_response :success
  end
end
