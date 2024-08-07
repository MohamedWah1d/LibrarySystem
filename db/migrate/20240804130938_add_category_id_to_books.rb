class AddCategoryIdToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :category_id, :integer, null:false, foreign_key: true
  end
end
