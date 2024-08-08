class ShelfSerializer
  include JSONAPI::Serializer

  set_type :shelf
  attributes :id, :name, :max_capacity

  attribute :books do |shelf|
    shelf.books.map do |book|
      {
        id: book.id,
        title: book.title,
        author: book.author,
        rating: book.rating,
        review_count: book.review_count
      }
    end
  end

  attribute :created_at do |shelf|
    shelf.created_at
  end

  attribute :updated_at do |shelf|
    shelf.updated_at
  end
end
