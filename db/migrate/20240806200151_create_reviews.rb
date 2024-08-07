class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :book_id, null: false
      t.integer :user_id, null: false
      t.float :rating, null: false
      t.text :comment, null: false

      t.timestamps
    end

    add_index :reviews, :book_id
    add_index :reviews, :user_id
    add_foreign_key :reviews, :books
    add_foreign_key :reviews, :users
  end
end
