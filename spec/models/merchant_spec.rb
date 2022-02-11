require 'rails_helper'

RSpec.describe Merchant do
  it { should have_many(:items)}

  describe 'class methods' do
    it 'finds merchant by name' do
      merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
      merchant_2 = Merchant.create!(name: "Horrors and Oddities")
      merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

      expect(Merchant.find_name("Horrors")).to eq(merchant_2)
      expect(Merchant.find_name("horrors")).to_not eq(merchant_1)
      expect(Merchant.find_name("horrors")).to_not eq(merchant_3)
    end
    
    it 'finds merchant by partial name' do
      merchant_1 = Merchant.create!(name: "Lil Shop of Horrors")
      merchant_2 = Merchant.create!(name: "Horrors and Oddities")
      merchant_3 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

      expect(Merchant.find_name("hoRr")).to eq(merchant_2)
      expect(Merchant.find_name("hoRr")).to_not eq(merchant_1)
      expect(Merchant.find_name("hoRr")).to_not eq(merchant_3)
    end

    it 'finds all merchants matching name' do
      merchant_1 = create(:merchant, name: "Lil Shop of Horrors")
      merchant_2 = create(:merchant, name: "Horrors and Oddities")
      merchant_3 = create(:merchant, name: "Ruff Crowd Pet Supplies")

      expect(Merchant.find_all_name("horror")).to eq([merchant_2, merchant_1])
      expect(Merchant.find_all_name("horror")).to_not eq(merchant_3)
    end
  end
end
