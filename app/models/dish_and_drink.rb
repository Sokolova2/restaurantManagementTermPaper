class DishAndDrink < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :chip_baskets_items, dependent: :destroy
  has_one_attached :image
end
