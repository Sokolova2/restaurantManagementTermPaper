class Order < ApplicationRecord
  belongs_to :table
  belongs_to :employee, optional:true
  has_many :order_items, dependent: :destroy

  def full_price
    order_items.map {|order_item| order_item.number_of_dishes * order_item.dish_and_drink.price }.sum
  end
end
