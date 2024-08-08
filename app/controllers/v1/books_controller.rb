class V1::BooksController < BaseV1Controller
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :authorize_admin!, only: [:create, :update, :destroy]
  before_action :set_book, only: %i[show update destroy]

  def index
    @books = BookFilterService.new(params).call
    render json: {
      message: 'Success',
      data: {
        books: @books.map { |book| serialize_book(book) }
      },
      extra: {
        total_count: @books.total_count,
        page_number: @books.current_page,
        page_size: @books.limit_value
      }
    }
  end

  def show
    render json: {
      message: 'Success',
      data: {
        book: serialize_book(@book)
      }
    }
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: {
        message: 'Success',
        data: {
          book: serialize_book(@book)
        }
      }, status: :created, location: v1_book_url(@book)
    else
      render json: { message: 'Error', errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: {
        message: 'Success',
        data: {
          book: serialize_book(@book)
        }
      }
    else
      render json: { message: 'Error', errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
    render json: {}, status: :no_content
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :rating, :review_count, :shelf_id, category_ids: [])
  end

  def serialize_book(book)
    serialized_book = BookSerializer.new(book).serializable_hash[:data][:attributes]
    localized_title = serialized_book.delete(:localized_title)
    localized_author = serialized_book.delete(:localized_author)

    localized_title.merge(localized_author).merge(serialized_book).merge(id: book.id)
  end
end
