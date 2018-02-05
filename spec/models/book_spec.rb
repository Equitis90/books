require 'rails_helper'

describe Book, type: :model do
  let(:genre) { FactoryBot.create(:genre) }
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.build(:book, user: user, genres: [genre]) }

  it 'creates valid book' do
    expect(book).to be_valid
  end

  it 'is not valid without ' do
    expect(book).to be_valid
  end
end