class BookCategory < ApplicationRecord
  belongs_to :Book
  belongs_to :category
end
