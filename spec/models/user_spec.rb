require 'rails_helper'

describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it 'creates valid user' do
    expect(user).to be_valid
  end

  it 'is not invalid without email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not invalid without password' do
    user.password = nil
    expect(user).to_not be_valid
  end
end