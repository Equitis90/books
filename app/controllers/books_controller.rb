# Books controller
class BooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_book, only: %i[show edit]

  def index
    @books = Book.where('created_at > ? and draft = false', Time.now - 7.days)
                 .order(updated_at: :desc)
  end

  def new
    @book = Book.new
  end

  def create
    Book.create_with_genres(book_params)
    redirect_to root_path, flash: { notice: 'New book review created!' }
  end

  def show
    authorize! :show, @book
  end

  def drafts
    @books = Book.where('user_id = ? and draft = true', current_user.id)
                 .order(:updated_at)
  end

  def edit
    authorize! :edit, @book
  end

  def update
    Book.edit_with_genres(book_params, params[:id])
    redirect_to root_path, flash: { notice: 'Changes saved!' }
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :user_id, :cover,
                                 :description, :draft, genres: [])
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
