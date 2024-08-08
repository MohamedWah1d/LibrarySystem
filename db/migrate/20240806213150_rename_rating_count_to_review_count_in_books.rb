class RenameRatingCountToReviewCountInBooks < ActiveRecord::Migration[7.1]
  def change
    rename_column :books, :rating_count, :review_count
  end
end
