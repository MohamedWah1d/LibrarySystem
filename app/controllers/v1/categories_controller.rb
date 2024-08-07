class V1::CategoriesController < BaseV1Controller
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :authorize_admin!, only: [:create, :update, :destroy]
  before_action :set_category, only: %i[ show update destroy ]

  def index
    @categories = Category.page(params[:page_number]).per(params[:page_size])

    render json: {
      message: 'Success',
      data: {
        categories: CategorySerializer.new(@categories).serializable_hash[:data].map do |category|
          category[:attributes]
        end
        },
      extra: {
        total_count: @categories.total_count,
        page_number: @categories.current_page,
        page_size: @categories.limit_value
      }
    }
  end

  def show
    render json: {
      message: 'Success',
      data: {
        category: CategorySerializer.new(@category).serializable_hash[:data][:attributes]
      }
    }
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: {
        message: 'Success',
        data: {
          category: CategorySerializer.new(@category).serializable_hash[:data][:attributes]
        }
      }, status: :created
    else
      render json: { message: 'Error', errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: {
        message: 'Success',
        data: {
          category: CategorySerializer.new(@category).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: { message: 'Error', errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
    render json: {}, status: :no_content
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
