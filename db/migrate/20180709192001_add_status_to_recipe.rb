class AddStatusToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :status, :string, default: 'draft'
  end
end
