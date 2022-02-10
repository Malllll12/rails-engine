class Api::V1::MerchantsSearchController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.find_all_name(params[:name]))
  end

  def show
    if params[:name] == "" || !params.include?(:name)
      render json: { errors: { details: "Please include search name." }}, status: 400
    elsif Merchant.find_name(params[:name]).nil?
      render json: { errors: { details: "This merchant does not exist." }}, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find_name(params[:name]))
    end
  end
end
