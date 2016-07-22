require 'rails_helper'

describe BooksController do

  describe "POST #create" do

    let(:invalid_params_error_message){ "invalid params" }
    let(:add_book_successful){ "Create a new book" }

    it 'returns Create a new book successfukl message and 201 response code when post successful' do
      @book = Book.new
      allow(Book).to receive(:new)
      allow(BooksHelper).to receive(:add).and_return(true)
      post :create
      expect(response.body).to include add_book_successful
      expect(response.status).to eql 201
    end

    it 'returns 500 error code when params is invalid' do
      @book = Book.new
      allow(Book).to receive(:new).and_return(@book)
      allow(BooksHelper).to receive(:add).and_return(false)
      post :create
      expect(response.status).to eql 500
   end

  end

end