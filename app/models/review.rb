class Review < ApplicationRecord
    belongs_to :user
    belongs_to :book
  
    validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
    validates :comment, presence: true
    validates :user_id, uniqueness: { scope: :book_id, message: "can only review a book once" }

    after_save :update_book_rating

    after_destroy :update_book_rating

    private

    def update_book_rating
      book.recalculate_rating_and_count
    end
end
  