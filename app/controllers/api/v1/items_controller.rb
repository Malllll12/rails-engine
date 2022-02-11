class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.valid? == true
      render json: ItemSerializer.new(Item.create(item_params)), status: 201
    else
      render json: { error: "Item cannot be created. Please check your input."}, status: 404
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item), status: 200
    else
      render json: { error: "Item cannot be updated. Please check your input."}, status: 400
    end
  end

  def destroy
    render json: Item.delete(params[:id]), status: 204
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
