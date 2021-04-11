class AddNumberOfToPantryItems < ActiveRecord::Migration[6.1]
  def change
    add_column :pantry_items, :number_of, :integer
  end
end
