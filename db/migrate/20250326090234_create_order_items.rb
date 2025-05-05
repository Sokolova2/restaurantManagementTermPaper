class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :dish_and_drink, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :number_of_dishes
      t.string :dish_status
      t.timestamps
    end
  end
end
