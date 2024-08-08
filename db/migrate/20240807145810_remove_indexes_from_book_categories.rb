class RemoveIndexesFromBookCategories < ActiveRecord::Migration[7.1]
  def change
    remove_index :book_categories, name: "index_book_categories_on_Book_id"
    remove_index :book_categories, name: "index_book_categories_on_category_id"
  end
end
