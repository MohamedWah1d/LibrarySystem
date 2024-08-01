class BookCategoriesController < ApplicationController
  before_action :set_book_category, only: %i[ show update destroy ]

  def index
    @book_categories = BookCategory.all

    render json: @book_categories
  end

  def show
    render json: @book_category
  end

  def create
    @book_category = BookCategory.new(book_category_params)

    if @book_category.save
      render json: @book_category, status: :created, location: @book_category
    else
      render json: @book_category.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book_category.update(book_category_params)
      render json: @book_category
    else
      render json: @book_category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book_category.destroy!
  end

  private
    def set_book_category
      @book_category = BookCategory.find(params[:id])
    end

    def book_category_params
      params.require(:book_category).permit(:Book_id, :category_id)
    end
end
