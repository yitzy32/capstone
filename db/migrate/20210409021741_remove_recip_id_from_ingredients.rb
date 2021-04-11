class RemoveRecipIdFromIngredients < ActiveRecord::Migration[6.1]
  def change
    remove_column :ingredients, :recipe_id, :integer
  end
end
