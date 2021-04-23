class AddNameToPantryItems < ActiveRecord::Migration[6.1]
  def change
    add_column :pantry_items, :name, :string
  end
end
