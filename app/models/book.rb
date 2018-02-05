# Book model class
class Book < ApplicationRecord
  belongs_to :user
  has_many :book_genres
  has_many :genres, through: :book_genres

  has_attached_file :cover, styles: { medium: '300x500>', thumb: '100x200>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\z}
  validates_presence_of :genres, :title, :author, :description, :user
  validates_inclusion_of :draft, in: [true, false]

  def self.create_with_genres(book_params)
    private_class_method
    new_book = params_with_genres(book_params)
    Book.create(new_book)
  end

  def self.edit_with_genres(book_params, id)
    private_class_method
    new_params = params_with_genres(book_params)
    book = Book.where(id: id).first
    new_params[:cover] = book.cover if new_params[:cover].blank?
    book.assign_attributes new_params
    book.save
  end

  def self.params_with_genres(book_params)
    private_class_method
    new_params = book_params
    genres = Genre.where(id: new_params[:genres]).to_a
    new_params[:genres] = genres
    new_params
  end
end
