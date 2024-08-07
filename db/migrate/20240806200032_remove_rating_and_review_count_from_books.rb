class RemoveRatingAndReviewCountFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :rating, :float
    remove_column :books, :review_count, :integer
  end
end
