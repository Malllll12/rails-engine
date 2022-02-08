require 'rails_helper'

RSpec.describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 10)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(10)

    merchants.each do |merchant|
      expect(merchant).to have_key("id")
      expect(merchant["id"]).to be_an(Integer)
      expect(merchant).to have_key("name")
      expect(merchant["name"]).to be_a(String)
    end
  end
end
