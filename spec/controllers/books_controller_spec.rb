require 'rails_helper'

describe BooksController do

  describe "POST #create" do

    let(:add_book_successful) { "Create a new book" }
    it 'returns Create a new book successfukl message and 201 response code when post successful' do
      allow(Book).to receive(:new)
      allow(BooksHelper).to receive(:save).and_return(true)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      post :create
      expect(response.body).to include add_book_successful
      expect(response.status).to eql 201
    end

    it 'returns 409 error code when params is invalid' do
      @book = Book.new
      allow(Book).to receive(:new).and_return(@book)
      allow(BooksHelper).to receive(:save).and_return(false)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      post :create
      expect(response.status).to eql 409
    end

    it 'return 401 error code when username or password is error' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw6661'
      post :create
      expect(response.body).to include{"username or password is error"}
      expect(response.status).to eql 401
    end

    it 'filter the illegal params by post_params'do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      allow(BooksHelper).to receive(:save).and_return(:true)
      Book.should_receive(:new).and_return({"name"=>"AlanD", "author"=>"iug", "isbn"=>"fhjak"}.with_indifferent_access)
      post :create, { first_name: 'Sideshow', last_name: 'Bob', name: 'AlanD',isbn:'fhjak',author:'iug' }
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
      @book = Book.create({name:'fhai',author:'ghai',isbn:'hajk'})
      get :show, :isbn => @book.isbn
      expect(response.status).to eql 200
    end

    it 'return 404 error when no books found' do
      get :show, :isbn => :isbn
      expect(response.status).to eql 404
    end
  end


  describe "PUT #update" do

    it 'return 404 error when no books found' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      put :update, :isbn => :isbn
      expect(response.status).to eql 404
    end

    it "returns Book updated and 202 code when update succeed" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      @book = Book.create({name:'fhai',author:'ghai',isbn:'hajk',img_url:'fahgaj'})
      allow(@book).to receive(:update).and_return(:true)
      put :update, :isbn => @book.isbn
      expect(response.body).to include {"Book updated!"}
      expect(response.status).to eql 202
    end

  end


  describe "DELETE #delete" do

    it 'return Book delete succeed and 200 code when delete succeed' do
      @book = Book.create({name:'fhai',author:'ghai',isbn:'hajk'})
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      allow(@book).to receive(:delete)
      delete :delete, :isbn => @book.isbn
      expect(response.status).to eql 200
    end

    it 'return 404 error when no books found' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'tw666'
      delete :delete, :isbn => :isbn
      expect(response.status).to eql 404
    end
  end


end
