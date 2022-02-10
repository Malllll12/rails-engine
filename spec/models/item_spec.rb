require 'rails_helper'

RSpec.describe Item do
  it { should belong_to(:merchant) }

  describe 'class methods' do
    it "finds all items by search criteria" do
      merchant = create(:merchant)
      item_1 = create(:item, name: "Horror Movie", merchant: merchant)
      item_2 = create(:item, name: "Romantic Movie", merchant: merchant)
      item_3 = create(:item, name: "Movies and Popcorn", merchant: merchant)

      expect(Item.find_all_items("movie")).to eq([item_1, item_3, item_2])
    end
  end
end
