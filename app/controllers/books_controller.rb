class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @books = Book.where('created_at > ?', Time.now - 7.days).order(:created_at)
  end

  def new
    @book = Book.new
  end
end
