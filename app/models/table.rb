class Table < ApplicationRecord
  # TODO: change order to orders
  has_many :order
  belongs_to :employee, optional:true
  belongs_to :client
  has_one :chip_basket
end
