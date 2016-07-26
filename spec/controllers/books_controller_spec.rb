require 'rails_helper'

describe BooksController do

  describe 'post_params' do
    it 'filter the illegal params in POST' do
      allow(BooksHelper).to receive(:save).and_return(:true)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      Book.should_receive(:new).and_return({"name" => "AlanD", "author" => "iug", "isbn" => "fhjak"}.with_indifferent_access)
      post :create, {first_name: 'Sideshow', last_name: 'Bob', name: 'AlanD', isbn: 'fhjak', author: 'iug'}
    end
  end

  describe 'check_log_in' do

    it 'return login error 401 when POST wrong login msg' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw6661'
      post :create
      expect(response.body).to include { "username or password is error" }
      expect(response.status).to eql 401
    end

    it 'return login error 401 when PUT with wrong login msg' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw6661'
      put :update, :isbn => :isbn
      expect(response.body).to include { "username or password is error" }
      expect(response.status).to eql 401
    end

    it 'return login error 401 when DELETE with wrong login msg' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw6661'
      delete :delete, :isbn => :isbn
      expect(response.body).to include { "username or password is error" }
      expect(response.status).to eql 401
    end

  end

  describe "POST #create" do

      before(:each) do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      end

      it 'returns Create a new book successfukl message and 201 response code when post successful' do
        allow(Book).to receive(:new)
        allow(BooksHelper).to receive(:save).and_return(true)
        post :create
        expect(response.body).to include {'Create a new book'}
        expect(response.status).to eql 201
      end

      it 'returns 409 error code when params is invalid' do
        book = double("book")
        book_errors = double("book_errors")
        book_errors_values = double("book_errors_values")
        book_errors_message = "book_errors_message"
        allow(Book).to receive(:new).and_return(book)
        allow(BooksHelper).to receive(:save).and_return(false)
        allow(book).to receive(:errors).and_return(book_errors)
        allow(book_errors).to receive(:values).and_return(book_errors_values)
        allow(book_errors_values).to receive(:join).with("; ").and_return(book_errors_message)
        post :create
        expect(response.body).to include book_errors_message
        expect(response.status).to eql 409
      end


  end


  describe "GET#index" do

    it 'GET the book list' do
      allow(Book).to receive (:select)
      get :index
      expect(response.status).to eql 200
    end

  end

  describe "GET#show" do

    it 'GET detail book[:isbn] message' do
      book = double("book")
      book_information = 'book_information'
      allow(book).to receive(:isbn).
      get :show, :isbn => book.isbn
      expect(response.body).to include(book_information)
      expect(response.status).to eql 200
    end

    it 'return 404 error when no books found' do
      get :show, :isbn => :isbn
      expect(response.body).to include("Book not found")
      expect(response.status).to eql 404
    end
  end


  describe "PUT #update" do

    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
    end

    it 'return 404 error when no books found' do
      put :update, :isbn => :isbn
      expect(response.body).to include("Book not found")
      expect(response.status).to eql 404
    end

    it "returns Book updated and 202 code when update succeed" do
      @book = Book.create({name: 'fhai', author: 'ghai', isbn: 'hajk', img_url: 'fahgaj'})
      allow(@book).to receive(:update).and_return(:true)
      put :update, :isbn => @book.isbn
      expect(response.body).to include { "Book updated!" }
      expect(response.status).to eql 202
    end

  end


  describe "DELETE #delete" do



    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      @book = Book.create({name: 'fhai', author: 'ghai', isbn: 'hajk'})
    end

    it 'return Book delete succeed and 200 code when delete succeed' do
      allow(@book).to receive(:delete)
      delete :delete, :isbn => @book.isbn
      expect(response.body).to include("Book delete succeed!")
      expect(response.status).to eql 200
    end

    it 'return 404 error when no books found' do
      delete :delete, :isbn => :isbn
      expect(response.body).to include("Book not found")
      expect(response.status).to eql 404
    end
  end

end
