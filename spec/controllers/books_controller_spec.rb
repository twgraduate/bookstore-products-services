require 'rails_helper'

describe BooksController do

  describe "GET#index" do
    it 'GET the book list' do
      allow(Book).to receive (:all)
      get :index
      expect(response.status).to eql 200
    end
  end

  describe "POST #create" do
    let(:add_book_successful) { "Create a new book" }
    it 'returns Create a new book successfukl message and 201 response code when post successful' do
      allow(Book).to receive(:check_logged_in)
      allow(Book).to receive(:new)
      allow(BooksHelper).to receive(:save).and_return(true)
      post :create
      expect(response.body).to include add_book_successful
      expect(response.status).to eql 201
    end
    it 'returns 409 error code when params is invalid' do
      @book = Book.new
      allow(Book).to receive(:check_logged_in)
      allow(Book).to receive(:new).and_return(@book)
      allow(BooksHelper).to receive(:save).and_return(false)
      post :create
      expect(response.status).to eql 409
    end
    it 'return 401 error code when username or password is error' do

    end
  end

  # describe "PUT #update" do
  #   it 'returns Book updated message and 202 response code when'
  # end

  # describe "set_book" do
  #   let(:book_not_found){'Book not found'}
  #   # it 'returns book[:isbn] message if isbn exsit' do
  #   #   allow(Book).to receive(:find_by_isbn).and_return(@book)
  #   #   expect(set_book).
  #   # end
  #   it 'return Book not found and 404 errors when book do not exsit' do
  #     allow(Book).to receive(:find_by_isbn).and_return(Exception)
  #     expect(response).to have_http_status 404
  #   end
  #
  # end

end
