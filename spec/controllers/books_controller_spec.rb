require 'rails_helper'
require 'devise'
require 'rack/test'

describe BooksController, type: :controller do
  let(:genre) { FactoryBot.create(:genre) }
  let(:user) { FactoryBot.create(:user) }
  let(:draft) { FactoryBot.create(:book, user: user, genres: [genre], draft: true) }
  let(:book) { FactoryBot.create(:book, user: user, genres: [genre]) }
  let(:book_params) do
    FactoryBot.attributes_for(:book, user: user, genres: [genre],
    cover: Rack::Test::UploadedFile.new("#{Rails.root}/spec/image.png", 'image/png'))
  end

  it 'is index page' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'is book review page' do
    get :show, params: { id: book.id }
    expect(response).to render_template(:show)
  end

  context 'Logged in user' do
    before do
      sign_in user
    end

    it 'is redirects to new book review page' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'is redirects to drafts page' do
      get :drafts
      expect(response).to render_template(:drafts)
    end

    it 'is redirects to draft edit page' do
      get :edit, params: { id: draft.id }
      expect(response).to render_template(:edit)
    end

    it 'is updates book and redirects to root' do
      post :update, params: { book: book_params, id: draft.id }
      expect(response).to redirect_to root_path
    end

    it 'is creates book and redirects to root' do
      post :create, params: { book: book_params }
      expect(response).to redirect_to root_path
    end
  end

  context 'Not logged in user' do
    it 'is redirects to sign in page' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it 'is redirects to sign in page' do
      get :drafts
      expect(response).to redirect_to new_user_session_path
    end

    it 'is redirects to sign in page' do
      get :edit, params: { id: draft.id }
      expect(response).to redirect_to new_user_session_path
    end

    it 'is redirects to sign in page' do
      post :update, params: { book: book_params, id: draft.id }
      expect(response).to redirect_to new_user_session_path
    end

    it 'is redirects to sign in page' do
      post :create, params: { book: book_params }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
