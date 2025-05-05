class AddTableToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :table, null: false, foreign_key: true
  end
end
