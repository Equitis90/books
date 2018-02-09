require 'rails_helper'
require 'devise'

feature 'User actions', type: :feature do
  scenario 'User creates a profile' do
    visit '/users/sign_up'

    fill_in 'Email', with: 'users@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  context 'Signed up user actions' do
    let(:book) { FactoryBot.build(:book) }
    let(:user) { FactoryBot.create(:user) }
    let(:option) { first('#book_genres option').text }

    scenario 'User logging in and creates a book review' do
      visit '/users/sign_in'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'

      visit '/books/new'

      fill_in 'Title', with: book.title
      fill_in 'Author', with: book.author
      attach_file('Cover', File.absolute_path("#{Rails.root}/spec/image.png"))
      fill_in 'Description', with: book.description

      select option, from: 'book[genres][]'
      click_button 'Create'

      expect(page).to have_text('New book review created!')
    end
  end
end