class V1::ShelvesController < BaseV1Controller
  before_action :authenticate_user!, only: [:index, :show, :create, :update, :destroy]
  before_action :authorize_admin!, only: [:create, :update, :destroy]
  before_action :set_shelf, only: %i[ show update destroy ]

  def index
    @shelves = Shelf.page(params[:page_number]).per(params[:page_size])

    render json: {
      message: 'Success',
      data: {
        shelves: ShelfSerializer.new(@shelves).serializable_hash[:data].map do |shelf|
          shelf[:attributes]
        end
        },
      extra: {
        total_count: @shelves.total_count,
        page_number: @shelves.current_page,
        page_size: @shelves.limit_value
      }
    }
  end

  def show
    render json: {
      message: 'Success',
      data: {
        shelf: ShelfSerializer.new(@shelf).serializable_hash[:data][:attributes]
      }
    }
  end

  def create
    @shelf = Shelf.new(shelf_params)

    if @shelf.save
      render json: {
        message: 'Success',
        data: {
          shelf: ShelfSerializer.new(@shelf).serializable_hash[:data][:attributes]
        }
      }, status: :created, location: v1_shelf_url(@shelf)
    else
      render json: { message: 'Error', errors: @shelf.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @shelf.update(shelf_params)
      render json: {
        message: 'Success',
        data: {
          shelf: ShelfSerializer.new(@shelf).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: { message: 'Error', errors: @shelf.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @shelf.destroy!
    render json: {}, status: :no_content
  end

  private
    def set_shelf
      @shelf = Shelf.find(params[:id])
    end

    def shelf_params
      params.require(:shelf).permit(:name, :max_capacity)
    end
end
