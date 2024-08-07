class BookSerializer
  include JSONAPI::Serializer

  set_type :book
  attributes :id, :rating, :review_count

  attribute :localized_title do |book|
    { I18n.t('book.title', default: 'title') => book.title }
  end

  attribute :localized_author do |book|
    { I18n.t('book.author', default: 'author') => book.author }
  end

  attribute :categories do |book|
    book.categories.map do |category|
      {
        id: category.id,
        I18n.t('category.name', default: 'name') => category.name
      }
    end
  end

  attribute :shelf do |book|
    {
      id: book.shelf.id,
      I18n.t('shelf.name', default: 'name') => book.shelf.name
    }
  end

  attribute :created_at do |book|
    book.created_at
  end

  attribute :updated_at do |book|
    book.updated_at
  end
  
end
