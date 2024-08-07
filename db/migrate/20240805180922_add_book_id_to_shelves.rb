class AddBookIdToShelves < ActiveRecord::Migration[7.1]
  def change
    add_column :shelves, :book_id, :integer
    add_foreign_key :shelves, :books
    add_index :shelves, :book_id
  end
end
