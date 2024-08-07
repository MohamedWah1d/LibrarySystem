class CategorySerializer

  include JSONAPI::Serializer

  set_type :category

  attributes :id, :name

  attribute :books do |category|
    category.books.map do |book|
      {
        id: book.id,
        title: book.title,
        author: book.author,
        rating: book.rating,
        review_count: book.review_count
      }
    end
  end

  attribute :created_at do |category|
    category.created_at
  end

  attribute :updated_at do |category|
    category.updated_at
  end
end
