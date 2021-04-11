class AddNumberOfToIngredientRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredient_recipes, :number_of, :integer
  end
end
