class AddSourceUrlToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :source_url, :string
  end
end
