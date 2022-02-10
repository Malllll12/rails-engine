class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_all_items(query)
    where(['name ILIKE ?', "%#{query}%"])
    .order('name asc')
  end
end
