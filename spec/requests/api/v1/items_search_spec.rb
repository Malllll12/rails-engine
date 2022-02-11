require 'rails_helper'

RSpec.describe "Item Search" do

  it 'finds a all items matching search term' do
    merchant = create(:merchant)
    item_1 = create(:item, name: "Horror Movie", merchant: merchant)
    item_2 = create(:item, name: "Romantic Movie", merchant: merchant)
    item_3 = create(:item, name: "Movies and Popcorn", merchant: merchant)

    get "/api/v1/items/find_all?name=movie"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(items.first[:attributes][:name]).to eq(item_1.name)
    expect(items.last[:attributes][:name]).to eq(item_2.name)
  end

  it 'fails if search term is not present' do
    merchant = create(:merchant)
    item_1 = create(:item, name: "Horror Movie", merchant: merchant)
    item_2 = create(:item, name: "Romantic Movie", merchant: merchant)
    item_3 = create(:item, name: "Movies and Popcorn", merchant: merchant)

    get "/api/v1/items/find_all?name="

    expect(response.status).to eq(400)
  end
end
