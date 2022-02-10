require 'rails_helper'

RSpec.describe Merchant do
  it { should have_many(:items)}

  describe 'class methods' do
    it 'finds merchant by name' do
      merchant = Merchant.create!(name: "Lil Shop of Horrors")
      merchant_2 = Merchant.create!(name: "Ruff Crowd Pet Supplies")

      expect(Merchant.find_name("Horrors").name).to eq(merchant.name)
      expect(Merchant.find_name("Horrors").name).to_not eq(merchant_2.name)
    end
  end
end
