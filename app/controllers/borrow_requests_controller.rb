class BorrowRequestsController < ApplicationController
  before_action :set_borrow_request, only: %i[ show update destroy ]

  def index
    @borrow_requests = BorrowRequest.all

    render json: @borrow_requests
  end

  def show
    render json: @borrow_request
  end

  def create
    @borrow_request = BorrowRequest.new(borrow_request_params)

    if @borrow_request.save
      render json: @borrow_request, status: :created, location: @borrow_request
    else
      render json: @borrow_request.errors, status: :unprocessable_entity
    end
  end

  def update
    if @borrow_request.update(borrow_request_params)
      render json: @borrow_request
    else
      render json: @borrow_request.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @borrow_request.destroy!
  end

  private
    def set_borrow_request
      @borrow_request = BorrowRequest.find(params[:id])
    end

    def borrow_request_params
      params.require(:borrow_request).permit(:user_id, :book_id, :borrow_date, :return_date, :intended_return_date, :status)
    end
end
