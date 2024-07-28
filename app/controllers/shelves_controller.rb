class ShelvesController < ApplicationController
  before_action :set_shelf, only: %i[ show update destroy ]

  def index
    @shelves = Shelf.all

    render json: @shelves
  end

  def show
    render json: @shelf
  end

  def create
    @shelf = Shelf.new(shelf_params)

    if @shelf.save
      render json: @shelf, status: :created, location: @shelf
    else
      render json: @shelf.errors, status: :unprocessable_entity
    end
  end

  def update
    if @shelf.update(shelf_params)
      render json: @shelf
    else
      render json: @shelf.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @shelf.destroy!
  end

  private
    def set_shelf
      @shelf = Shelf.find(params[:id])
    end

    def shelf_params
      params.require(:shelf).permit(:name, :max_capacity)
    end
end
