class RemoveCategoryIdFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :category_id, :integer
  end
end
