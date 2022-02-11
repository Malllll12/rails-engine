class Api::V1::ItemsSearchController < ApplicationController
  def index
    if params[:name] == "" || !params.include?(:name)
      render json: { errors: { details: "Please include search name." }}, status: 400
    else
      render json: ItemSerializer.new(Item.find_all_items(params[:name]))
    end
  end
end
