require 'rails_helper'

describe Book, type: :model do
  let(:genre) { FactoryBot.create(:genre) }
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.build(:book, user: user, genres: [genre]) }

  it 'creates valid book' do
    expect(book).to be_valid
  end

  it 'is not valid without genres' do
    book.genres = []
    expect(book).to_not be_valid
  end

  it 'is not valid without title' do
    book.title = nil
    expect(book).to_not be_valid
  end

  it 'is not valid without draft' do
    book.title = nil
    expect(book).to_not be_valid
  end

  it 'is not valid without cover' do
    book.cover = nil
    expect(book).to_not be_valid
  end

  it 'is not valid without user' do
    book.user = nil
    expect(book).to_not be_valid
  end

  it 'is not valid without description' do
    book.description = nil
    expect(book).to_not be_valid
  end

  it 'is not valid without author' do
    book.author = nil
    expect(book).to_not be_valid
  end
end