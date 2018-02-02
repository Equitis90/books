class Book < ApplicationRecord
  belongs_to :user
  has_many :book_genres
  has_many :genres, through: :book_genres

  has_attached_file :cover, styles: { medium: "300x500>", thumb: "100x200>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
  validates_presence_of :genres, :title, :author, :description, :draft, :user
end
