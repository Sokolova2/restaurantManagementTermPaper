class CreateDishAndDrinks < ActiveRecord::Migration[8.0]
  def change
    create_table :dish_and_drinks do |t|
      t.string :name
      t.float :grams
      t.string :category
      t.string :category_type
      t.float :price

      t.timestamps
    end
  end
end
