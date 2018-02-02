class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @books = Book.where('created_at > ?', Time.now - 7.days).order(:created_at)
  end

  def new
    @book = Book.new
  end

  def create
    pr = book_params
    genres = Genre.where(id: pr[:genres]).to_a
    pr[:genres] = genres
    Book.create(pr)
    redirect_to root_path
  end

  def show
    @book = Book.where(id: params[:id]).first
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :user_id, :cover,
                                 :description, :draft, genres: [])
  end
end
