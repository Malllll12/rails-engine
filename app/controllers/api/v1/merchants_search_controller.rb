class Api::V1::MerchantsSearchController < ApplicationController

  def index
    if params[:name] == "" || !params.include?(:name)
      render json: { data: [{ details: "Please include search name." }]}, status: 400
    elsif Merchant.find_name(params[:name]).nil?
      render json: { data: []}, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find_all_name(params[:name]))
    end
  end

  def show
    if params[:name] == "" || !params.include?(:name)
      render json: { data: { details: "Please include search name." }}, status: 400
    elsif Merchant.find_name(params[:name]).nil?
      render json: { data: { details: "This merchant does not exist." }}, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find_name(params[:name]))
    end
  end
end
