class Genre < ApplicationRecord
  has_many :book_genres
  has_many :books, through: :book_genres

  validates_presence_of :title
  validates_uniqueness_of :title
end
