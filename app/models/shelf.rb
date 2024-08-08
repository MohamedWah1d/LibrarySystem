class Shelf < ApplicationRecord
    has_many :books

    validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
    validates :max_capacity, presence: true, numericality: { only_integer: true, greater_than: 0}
end
