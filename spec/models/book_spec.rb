require 'rails_helper'

describe Book, type: :model do
  let(:genre) { FactoryBot.create(:genre) }
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.build(:book, user: user, genres: [genre]) }

  it 'creates valid book' do
    expect(book).to be_valid
  end

  it { should validate_presence_of :genres }

  it { should validate_presence_of :title }

  it { should validate_presence_of :cover }

  it { should validate_presence_of :user }

  it { should validate_presence_of :description }

  it { should validate_presence_of :author }

  it { should have_many :book_genres }
end