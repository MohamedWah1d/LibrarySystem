require "test_helper"

class BorrowRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @borrow_request = borrow_requests(:one)
  end

  test "should get index" do
    get borrow_requests_url, as: :json
    assert_response :success
  end

  test "should create borrow_request" do
    assert_difference("BorrowRequest.count") do
      post borrow_requests_url, params: { borrow_request: { book_id: @borrow_request.book_id, borrow_date: @borrow_request.borrow_date, intended_return_date: @borrow_request.intended_return_date, return_date: @borrow_request.return_date, status: @borrow_request.status, user_id: @borrow_request.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show borrow_request" do
    get borrow_request_url(@borrow_request), as: :json
    assert_response :success
  end

  test "should update borrow_request" do
    patch borrow_request_url(@borrow_request), params: { borrow_request: { book_id: @borrow_request.book_id, borrow_date: @borrow_request.borrow_date, intended_return_date: @borrow_request.intended_return_date, return_date: @borrow_request.return_date, status: @borrow_request.status, user_id: @borrow_request.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy borrow_request" do
    assert_difference("BorrowRequest.count", -1) do
      delete borrow_request_url(@borrow_request), as: :json
    end

    assert_response :no_content
  end
end
