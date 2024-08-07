class V1::BorrowRequestsController < BaseV1Controller
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [ :update ]
  before_action :set_borrow_request, only: [ :update, :return, :show ]
  before_action :authorize_user!, only: [:return]
  before_action :validate_return_status, only: [ :return ]

  def index
    @borrow_requests = BorrowRequest.page(params[:page_number]).per(params[:page_size])

    render json: {
      message: 'Success',
      data: {
        requests: BorrowRequestSerializer.new(@borrow_requests).serializable_hash[:data].map do |request|
          request[:attributes]
        end
        },
      extra: {
        total_count: @borrow_requests.total_count,
        page_number: @borrow_requests.current_page,
        page_size: @borrow_requests.limit_value
      }
    }
  end

  def show
    render json: {
      message: 'Success',
      data: {
        request: BorrowRequestSerializer.new(@borrow_request).serializable_hash[:data][:attributes]
      }
    }
  end

  def create
    @borrow_request = current_user.borrow_requests.new(borrow_request_params)
    @borrow_request.borrow_date = Time.current
    @borrow_request.status = :pending

    if @borrow_request.save
      render json: {
        message: 'Success',
        data: {
          request: BorrowRequestSerializer.new(@borrow_request).serializable_hash[:data][:attributes]
        }
      }, status: :created
    else
      render json: { message: 'Error', errors: @borrow_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @borrow_request.update(borrow_request_params)
      render json: {
        message: 'Success',
        data: {
          request: BorrowRequestSerializer.new(@borrow_request).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: { message: 'Error', errors: @borrow_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def return
    if @borrow_request.update(status: :returned, return_date: Time.current)
      render json: {
        message: 'Success',
        data: {
          request: BorrowRequestSerializer.new(@borrow_request).serializable_hash[:data][:attributes]
        }
      }
    else
      render json: { message: 'Error', errors: @borrow_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_borrow_request
    @borrow_request = BorrowRequest.find(params[:id])
  end

  def borrow_request_params
    params.require(:borrow_request).permit(:book_id, :intended_return_date, :status)
  end

  def authorize_user!
    unless current_user.admin? || @borrow_request.user_id == current_user.id
      render json: {
         message: 'Error', errors: ['You are not authorized to perform this action'] 
         }, status: :forbidden
    end
  end

  def validate_return_status
    if %w[pending returned rejected].include?(@borrow_request.status)
      render json: { message: 'Error', errors: ['This book cannot be returned!'] }, status: :unprocessable_entity
    end
  end
end
