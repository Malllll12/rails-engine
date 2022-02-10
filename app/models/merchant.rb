class Merchant < ApplicationRecord
  has_many :items

  def self.find_name(query)
    # binding.pry
    where(['name LIKE ?', "%#{query}%"])
    .order('name asc')
    .first
  end
end
