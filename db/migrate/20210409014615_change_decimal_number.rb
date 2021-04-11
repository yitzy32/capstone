class ChangeDecimalNumber < ActiveRecord::Migration[6.1]
  def change
    change_column :ingredient_recipes, :measurement_in_ml, :decimal, precision: 7, scale: 3
    change_column :pantry_items, :measurement_in_ml, :decimal, precision: 7, scale: 3
  end
end
