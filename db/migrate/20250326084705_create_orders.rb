class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :employee, null: true, foreign_key: true
      t.string :order_status

      t.timestamps
    end
  end
end
