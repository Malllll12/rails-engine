require 'rails_helper'

RSpec.describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 10)

    get api_v1_merchants_path

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(merchants.count).to eq(10)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'gets a merchant by id' do
    id = create(:merchant).id

    get api_v1_merchant_path(id)

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]

    expect(response).to be_successful

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'gets a merchants items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get api_v1_merchant_items_path(merchant.id)

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant_items = parsed[:data]

    expect(response).to be_successful

    merchant_items.each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end
end
