class CreateChipBasket < ActiveRecord::Migration[8.0]
  def change
    create_table :chip_baskets do |t|
      t.references :table, null: true, foreign_key: true

      t.timestamps
    end
  end
end
