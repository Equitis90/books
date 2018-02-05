# Books controller
class BooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @books = Book.where('created_at > ? and draft = false', Time.now - 7.days)
                 .order(updated_at: :desc)
  end

  def new
    @book = Book.new
  end

  def create
    Book.create_with_genres(book_params)
    redirect_to root_path
  end

  def show
    @book = Book.where(id: params[:id]).first
  end

  def drafts
    @books = Book.where('user_id = ? and draft = true', current_user.id)
                 .order(:updated_at)
  end

  def edit
    @book = Book.where(id: params[:id]).first
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
end
