require "test_helper"

class V1::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get v1_reviews_create_url
    assert_response :success
  end
end
