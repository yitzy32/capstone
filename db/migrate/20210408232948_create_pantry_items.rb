class CreatePantryItems < ActiveRecord::Migration[6.1]
  def change
    create_table :pantry_items do |t|
      t.integer :ingredient_id
      t.decimal :measurement_in_ml, precision: 6, scale: 3
      t.integer :user_id

      t.timestamps
    end
  end
end
