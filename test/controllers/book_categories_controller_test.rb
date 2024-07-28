require "test_helper"

class BookCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_category = book_categories(:one)
  end

  test "should get index" do
    get book_categories_url, as: :json
    assert_response :success
  end

  test "should create book_category" do
    assert_difference("BookCategory.count") do
      post book_categories_url, params: { book_category: { Book_id: @book_category.Book_id, category_id: @book_category.category_id } }, as: :json
    end

    assert_response :created
  end

  test "should show book_category" do
    get book_category_url(@book_category), as: :json
    assert_response :success
  end

  test "should update book_category" do
    patch book_category_url(@book_category), params: { book_category: { Book_id: @book_category.Book_id, category_id: @book_category.category_id } }, as: :json
    assert_response :success
  end

  test "should destroy book_category" do
    assert_difference("BookCategory.count", -1) do
      delete book_category_url(@book_category), as: :json
    end

    assert_response :no_content
  end
end
