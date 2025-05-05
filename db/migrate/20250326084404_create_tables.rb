class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.integer :table_number
      t.string :link_for_web
      t.references :employee, null: false, foreign_key: true
      t.references :client, null: true, foreign_key: true

      t.timestamps
    end
  end
end
