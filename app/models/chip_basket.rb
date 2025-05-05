class ChipBasket < ApplicationRecord
  belongs_to :table
  has_many :chip_basket_items, dependent: :destroy

  def full_price
    chip_basket_items.map {|chip_basket_item| chip_basket_item.number_of_dish * chip_basket_item.dish_and_drink.price }.sum
  end
end
