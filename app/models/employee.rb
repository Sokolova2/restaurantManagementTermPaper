class Employee < ApplicationRecord
  has_many :orders
  has_many :tables

  def full_name
    "#{last_name} #{first_name} #{parent_name}".strip
  end
end
