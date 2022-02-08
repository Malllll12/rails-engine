FactoryBot.define do
  factory :item do
    name { Faker::Item.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price(range: 0..10.0)}
    merchant_id { Faker::Number.between(from: 1, to: 10)}
  end
end
