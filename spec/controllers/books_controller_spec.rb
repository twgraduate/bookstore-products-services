require 'rails_helper'

describe BooksController do

  before(:each) do
    DatabaseCleaner.clean
  end

  describe 'check_log_in' do
    before(:each) do
      allow(request.env['HTTP_AUTHORIZATION']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    it 'return login error 401 when POST#create wrong login msg' do
      post :create
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'return login error 401 when PUT#update wrong login msg' do
      put :update,
          params: {:isbn => :isbn}
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'return login error 401 when DELETE#delete wrong login msg' do
      delete :delete,
             params: {:isbn => :isbn}
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

  end

  describe 'set_book' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      selected_information = double('selected_information')
      allow(Book).to receive(:select).and_return(selected_information)
      allow(selected_information).to receive(:find_by_isbn).and_return(nil)
    end

    it 'return 404 error when GET#show found no book' do
      get :show,
          params: {:isbn => :isbn}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'return 404 error when PUT#update found no book' do
      put :update,
          params: {:isbn => :isbn}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'return 404 error when DELETE#delete found no book' do
      delete :delete,
             params: {:isbn => :isbn}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end
  end

  describe "POST #create" do

    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
    end

    it 'returns Create a new book successfukl message and 201 response code when post successful' do
      allow(Book).to receive(:new).and_return(@book)
      allow(@book).to receive(:save).and_return(true)
      post :create
      expect(response.body).to include ('Create a new book')
      expect(response.status).to eql 201
    end

    it 'returns 409 error code when params is invalid' do
      book = double("book")
      book_errors = double("book_errors")
      book_errors_values = double("book_errors_values")
      book_errors_message = "book_errors_message"
      allow(Book).to receive(:new).and_return(book)
      allow(book).to receive(:save).and_return(false)
      allow(book).to receive(:errors).and_return(book_errors)
      allow(book_errors).to receive(:values).and_return(book_errors_values)
      allow(book_errors_values).to receive(:join).with("; ").and_return(book_errors_message)
      post :create
      expect(response.body).to include ("book_errors_message")
      expect(response.status).to eql 400
    end

    it 'return increased message after filter when post succeed' do
      allow(@book).to receive(:save).and_return(true)
      expect(Book).to receive(:new).with(hash_including("name" => "AlanD", "author" => "iug", "isbn" => "fhjak"))
      post :create,
           params: {first_name: 'Sideshow', last_name: 'Bob', name: 'AlanD', isbn: 'fhjak', author: 'iug'}
    end

  end

  describe "GET#index" do

    it 'return the book list when get the index' do
      allow(Book).to receive(:select).and_return('book list information')
      get :index
      expect(response.body).to include('book list information')
      expect(response.status).to eql 200
    end

  end

  describe "DELETE #delete" do
    it 'return Book delete succeed and 200 code when delete succeed' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      selected_information = double('selected_information')
      book_information = double('book_information')
      allow(Book).to receive(:select).and_return(selected_information)
      allow(selected_information).to receive(:find_by_isbn).and_return(book_information)
      allow(book_information).to receive(:destroy)
      delete :delete,
             params: {:isbn => :isbn}
      expect(response.body).to include("Book delete succeed!")
      expect(response.status).to eql 200
    end
  end

  describe "GET#show" do

    it 'returns book[:isbn] detail message when show it' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      selected_information = double('selected_information')
      allow(Book).to receive(:select).and_return(selected_information)
      allow(selected_information).to receive(:find_by_isbn).and_return('book information')
      get :show,
          params: {isbn: selected_information}
      expect(response.body).to include('book information')
      expect(response.status).to eql 200
    end
  end

  describe "PUT #update" do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      @book = create(:book, name: 'A name', isbn: 'ga', author: 'An author', price: 13, img_url: 'An url', description: 'A description')
    end

    it "returns Book updated and 202 code when update succeed" do
      selected_information = double('selected_information')
      book_information = double('book_information')
      allow(Book).to receive(:select).and_return(selected_information)
      allow(selected_information).to receive(:find_by_isbn).and_return(book_information)
      allow(book_information).to receive(:update).and_return(:true)
      put :update,
          params: {:isbn => :isbn}
      expect(response.body).to include { "Book updated!" }
      expect(response.status).to eql 202
    end

    it 'return the updated information when put params' do
      put :update,
          params: {isbn: @book, :name => 'New name', :img_url => 'New url'}
      @book.reload
      expect(@book.name).to eq ('A name')
      expect(@book.img_url).to eq ('New url')
    end
  end

  DatabaseCleaner.clean
end


