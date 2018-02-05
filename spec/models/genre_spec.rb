require 'rails_helper'

describe Genre, type: :model do
  let(:genre) { FactoryBot.build(:genre) }

  it 'creates valid genre' do
    expect(genre).to be_valid
  end

  it 'not create invalid genre' do
    genre.title = nil
    expect(genre).to_not be_valid
  end
end
