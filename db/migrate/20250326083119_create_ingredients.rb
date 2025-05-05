class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients do |t|
      t.references :dish_and_drink, null: false, foreign_key: true
      t.string :name
      t.float :grams

      t.timestamps
    end
  end
end
