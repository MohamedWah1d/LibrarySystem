class BorrowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: { pending: 0, approved: 1, returned: 2, rejected: 3 }

  validates :intended_return_date, presence: true
  validate :valid_intended_return_date
  validate :book_availability, on: :create


  private

  def valid_intended_return_date
    errors.add(:intended_return_date, "must be in the future") if intended_return_date <= Date.today
  end

  def book_availability
    active_borrow_requests = BorrowRequest.where(book_id: book_id).where(status: [:pending, :approved])
    if active_borrow_requests.exists?
      errors.add(:book_id, "is not available for borrowing, or an request is being reviewed by the admin")
    end
  end
end
