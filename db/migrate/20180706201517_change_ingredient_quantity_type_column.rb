class ChangeIngredientQuantityTypeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :ingredients, :type, :qty_type
  end
end
