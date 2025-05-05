class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :password
      t.string :last_name
      t.string :first_name
      t.string :parent_name
      t.string :job_title
      t.string :phone_number

      t.timestamps
    end
  end
end
