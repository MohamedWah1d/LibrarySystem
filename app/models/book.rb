class Book < ApplicationRecord
  belongs_to :shelf

  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :borrow_requests
  has_many :users, through: :borrow_requests
  has_many :reviews

  validates :title, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :author, presence: true, length: { minimum: 2 }
  validate :shelf_capacity_not_exceeded
  validate :categories_count_within_limit

  def categories_count_within_limit
    if categories.size > 3
      errors.add(:categories, "cannot have more than 3 categories")
    end
  end

  def recalculate_rating_and_count
    self.review_count = reviews.count
    self.rating = reviews.average(:rating).to_f
    save
  end

  private

  def shelf_capacity_not_exceeded
    return if shelf.nil?
    if new_record? || shelf_id_changed?
      if shelf.books.count >= shelf.max_capacity
        errors.add( :shelf, "has reached it's maximum capacity" )
      end
    end
  end
end
