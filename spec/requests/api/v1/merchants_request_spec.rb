require 'rails_helper'

RSpec.describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 10)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(10)

    merchants.each do |merchant|
      expect(merchant.last[0][:attributes]).to have_key(:id)
      expect(merchant.last[0][:attributes][:id]).to be_an(Integer)
      expect(merchant.last[0][:attributes]).to have_key(:name)
      expect(merchant.last[0][:attributes][:name]).to be_a(String)
    end
  end

  it 'gets a merchant by id' do
    id = create(:merchant).id

    get api_v1_merchant_path(id)

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data][:attributes]).to have_key(:id)
    expect(merchant[:data][:attributes][:id]).to eq(id)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
