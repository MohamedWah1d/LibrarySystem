class BorrowRequestSerializer
  include JSONAPI::Serializer

  set_type :borrow_request

  attributes :id, :borrow_date, :return_date, :intended_return_date, :status

  attribute :user do |borrow_request|
    {
      user_id: borrow_request.user.id,
      name: borrow_request.user.name,
      email: borrow_request.user.email,
      user_type: borrow_request.user.user_type
    }
  end

  attribute :book do |borrow_request|
    {
      book_id: borrow_request.book.id,
      title: borrow_request.book.title,
      author: borrow_request.book.author,
      rating: borrow_request.book.rating,
      review_count: borrow_request.book.review_count
    }
  end

  attribute :created_at do |borrow_request|
    borrow_request.created_at
  end

  attribute :updated_at do |borrow_request|
    borrow_request.updated_at
  end
end
