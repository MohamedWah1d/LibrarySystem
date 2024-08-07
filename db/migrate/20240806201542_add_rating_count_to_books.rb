class AddRatingCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :rating_count, :integer, default: 0, null: false
  end
end
