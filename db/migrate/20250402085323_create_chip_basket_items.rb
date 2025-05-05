class CreateChipBasketItems < ActiveRecord::Migration[8.0]
  def change
    create_table :chip_basket_items do |t|
      t.references :chip_basket, index: true, foreign_key: true
      t.references :dish_and_drink, null: false, foreign_key: true
      t.integer :number_of_dish

      t.timestamps
    end
  end
end
