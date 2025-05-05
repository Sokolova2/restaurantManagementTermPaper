class OrderItem < ApplicationRecord
  belongs_to :dish_and_drink
  has_many :orders
end
