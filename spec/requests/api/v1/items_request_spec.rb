require 'rails_helper'

RSpec.describe "Item API" do
  it "gets a list of all items" do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get api_v1_items_path

    parsed = JSON.parse(response.body, symbolize_names: true)
    items = parsed[:data]

    expect(response).to be_successful

    expect(items.count).to eq(5)

    items.each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'gets an item' do
    merchant = create(:merchant)
    id = merchant.items.create!(name: "Cool thing", description: "It's neat", unit_price: 3.0).id

    get api_v1_item_path(id)

    parsed = JSON.parse(response.body, symbolize_names: true)
    item = parsed[:data]
    expect(response).to be_successful

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
  end

  it 'creates an item' do
    merchant = create(:merchant)
    item_params = {
                    name: "Audrey 2",
                    description: "carnivorous",
                    unit_price: 100.99,
                    merchant_id: merchant.id
                  }
    post api_v1_items_path, params: item_params

    expect(response.status).to eq(201)
    expect(Item.last.name).to eq("Audrey 2")
    expect(Item.last.description).to eq("carnivorous")
    expect(Item.last.unit_price).to eq(100.99)
  end

  it 'updates an item' do
    merchant = create(:merchant)
    item = merchant.items.create!(name: "Cool thing", description: "Not at all suspicious", unit_price: 3.0)



  end

  it 'deletes an item' do
    merchant = Merchant.create!(name: "Guy in an oversized overcoat")
    item = merchant.items.create!(name: "Cool thing", description: "Not at all suspicious", unit_price: 3.0)

    delete api_v1_item_path(item.id)

    expect(response.status).to eq(204)
    expect(response.body).to be_empty
  end

end
