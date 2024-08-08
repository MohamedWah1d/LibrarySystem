class V1::ReviewsController < BaseV1Controller
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :update, :destroy]
  before_action :set_book, only: [:create, :index]
  before_action :authorize_user!, only: [:update, :destroy]
  before_action :check_if_user_returned_book, only: [:create]

  def index
    @reviews = Review.page(params[:page_number]).per(params[:page_size])

    render json: {
      message: 'Success',
      data: {
        reviews: ReviewSerializer.new(@reviews).serializable_hash[:data].map do |review|
          review[:attributes]
        end
      },
      extra: {
        total_count: @reviews.total_count,
        page_number: @reviews.current_page,
        page_size: @reviews.limit_value
      }
    }
  end

  def show
    render json: {
      message: 'Success',
      data: {
        review: ReviewSerializer.new(@review).serializable_hash[:data][:attributes]
      }
    }
  end

  def create
    @review = @book.reviews.new(review_params.merge(user: current_user))

    if @review.save
      render json: {
        message: 'Success',
        data: {
          review: ReviewSerializer.new(@review).serializable_hash[:data][:attributes]
        }
      }, status: :created
    else
      render json: { message: 'Error', errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: {
        message: 'Success',
        data: {
          review: ReviewSerializer.new(@review).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: { message: 'Error', errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy!
    render json: {}, status: :no_content
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def authorize_user!
    unless current_user.admin? || @review.user_id == current_user.id
      render json: { message: 'Error', errors: ['You are not authorized to perform this action'] }, status: :forbidden
    end
  end

  def check_if_user_returned_book
    unless current_user.borrow_requests.exists?(book_id: @book.id, status: :returned)
      render json: { message: 'Error', errors: ['You must borrow and return the book before you can review it'] }, status: :forbidden
    end
  end
end
