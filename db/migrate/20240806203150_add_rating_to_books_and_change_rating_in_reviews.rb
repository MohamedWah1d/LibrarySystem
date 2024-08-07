class AddRatingToBooksAndChangeRatingInReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :rating, :float, default: 0.0, null: false

    change_column :reviews, :rating, :float
  end
end
