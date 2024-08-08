class ReviewSerializer
  include JSONAPI::Serializer

  set_type :review

  attributes :id, :rating, :comment

  attribute :user do |review|
    {
      user_id: review.user.id,
      name: review.user.name,
      email: review.user.email,
      user_type: review.user.user_type
    }
  end

  attribute :book do |review|
    {
      book_id: review.book.id,
      title: review.book.title,
      author: review.book.author,
      rating: review.book.rating,
      review_count: review.book.review_count
    }
  end

  attribute :created_at do |review|
    review.created_at
  end

  attribute :updated_at do |review|
    review.updated_at
  end
end
