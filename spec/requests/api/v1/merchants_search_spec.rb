require 'rails_helper'

RSpec.describe "Merchant Search" do

  it 'finds all merchant matching search term' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find_all?name=horror"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(merchants.first[:attributes][:name]).to eq(merchant_2.name)
    expect(merchants.last[:attributes][:name]).to eq(merchant_1.name)
  end

    xit 'finds a single merchant by search term' do
      merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
      merchant_2 = Merchant.create!(name: "Horrors and Oddities")
      merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

      get "/api/v1/merchants/find?name=horror"

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)

      binding.pry
      # expect(parsed[:data][:attributes][:name]).to eq(merchant_1.name)
    end

end
