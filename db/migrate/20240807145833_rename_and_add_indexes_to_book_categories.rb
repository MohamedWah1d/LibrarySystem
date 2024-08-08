class RenameAndAddIndexesToBookCategories < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_categories, :Book_id, :book_id
    rename_column :book_categories, :category_id, :category_id

    add_index :book_categories, :book_id
    add_index :book_categories, :category_id
  end
end
