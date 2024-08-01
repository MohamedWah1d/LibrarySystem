class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.float :rating
      t.integer :review_count
      t.references :shelf, null: false, foreign_key: true

      t.timestamps
    end
  end
end
