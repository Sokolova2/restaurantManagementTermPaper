class CreateFeedbackAndSuggestions < ActiveRecord::Migration[8.0]
  def change
    create_table :feedback_and_suggestions do |t|
      t.string :feedback
      t.string :phone_number
      t.references :client, null: true, foreign_key: true

      t.timestamps
    end
  end
end
