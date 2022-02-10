class Merchant < ApplicationRecord
  has_many :items

  def self.find_name(query)
    where(['name ILIKE ?', "%#{query}%"])
    .order('name asc')
    .limit(1)
    .first
  end

  def self.find_all_name(query)
    where(['name ILIKE ?', "%#{query}%"])
    .order('name asc')
  end
end
