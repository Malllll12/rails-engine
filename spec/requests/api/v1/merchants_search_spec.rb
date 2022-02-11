require 'rails_helper'

RSpec.describe "Merchant Search" do

  it 'finds all merchants matching search term' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find_all?name=horror"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(merchants.first[:attributes][:name]).to eq(merchant_2.name)
    expect(merchants.last[:attributes][:name]).to eq(merchant_1.name)
    expect(merchants).to be_an(Array)
  end

  it 'fails to find all merchant matching search term' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find_all?name="

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]

    expect(response.status).to eq(400)
    expect(merchants).to be_an(Array)
  end

  it 'fails to find all merchant matching search term' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find_all?name=12235"

    parsed = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed[:data]
    
    expect(response.status).to eq(404)
    expect(merchants).to be_an(Array)
  end

  it 'finds a single merchant by search term' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find?name=horror"

    expect(response).to be_successful
    parsed = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed[:data]

    expect(merchant[:attributes][:name]).to eq(merchant_2.name)
  end

  it 'returns 400 if no input is given' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find?name="

    expect(response.status).to eq(400)
  end

  it 'returns 404 if bad input is given' do
    merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
    merchant_2 = Merchant.create!(name: "Horrors and Oddities")
    merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

    get "/api/v1/merchants/find?name=12345"

    expect(response.status).to eq(404)
  end
end
