class CreateIngredientRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_recipes do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.decimal :measurement_in_ml, precision: 6, scale: 3

      t.timestamps
    end
  end
end
