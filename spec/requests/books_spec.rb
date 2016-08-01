require 'rails_helper'

RSpec.describe "Books", type: :request do

  DatabaseCleaner.clean


  describe 'POST#create' do

    it 'return login error 401 when POST#create wrong login msg' do
      post '/books',
           params:{name: 'name1', isbn: 'isbn1', author: 'author1', price: 1, img_url: 'Url1', description: 'Description1'},
           env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw6661')}
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'post the data into the sql when data is validate' do
      post '/books',
           params:{name: 'name1', isbn: 'isbn1', author: 'author1', price: 1, img_url: 'Url1', description: 'Description1'},
           env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include ('Create a new book')
      expect(response.status).to eql 201
      expect(response.content_type).to eq("application/json")
      post '/books',
           params:{name: 'name2', isbn: 'isbn2', author: 'author2', price: 2, img_url: 'Url2', description:  'Description2'},
           env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include ('Create a new book')
      expect(response.status).to eql 201
      expect(response.content_type).to eq("application/json")
    end

    it 'reject the params when data is invalidate' do
      post '/books',
           params:{isbn: 'isbn1', author: 'author1', price: 1, img_url: 'Url1', description:  'Description1'},
           env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include ('Name can not be empty')
      expect(response.status).to eql 409
      expect(response.content_type).to eq("application/json")
    end

  end


  describe 'GET#index' do
    it 'returns the book list' do
      get '/books',
          env:{:HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin','tw666')}
      expect(response.content_type).to eq("application/json")
      # expect(response.body).to include_json(
      #                               [
      #                                 {
      #                                   "name":"name1"
      #                                 },
      #                                 {
      #                                   "name":"name2"
      #                                 }
      #                               ]
      #                          )
      expect(response.body).to eq\
        "[{\"name\":\"name1\",\"isbn\":\"isbn1\",\"author\":\"author1\",\"price\":1,\"img_url\":\"Url1\",\"description\":\"Description1\"},{\"name\":\"name2\",\"isbn\":\"isbn2\",\"author\":\"author2\",\"price\":2,\"img_url\":\"Url2\",\"description\":\"Description2\"}]"
    end
  end


  describe 'GET#show' do

    it 'renturn Book not found when isbn do not exsist' do
      get '/books/isbnnil',
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'return the book message when book is found depends on isbn' do
      get '/books/isbn1',
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to eq \
            "{\"name\":\"name1\",\"isbn\":\"isbn1\",\"author\":\"author1\",\"price\":1,\"img_url\":\"Url1\",\"description\":\"Description1\"}"
      expect(response.status).to eql 200
    end
  end

  describe 'PUT#update' do

    it 'return login error 401 when PUT#update with wrong login msg' do
      put '/books/isbn1',
          params:{isbn: 'isbn3', author: 'author3', price: 3, img_url: 'Url3', description:  'Description3'},
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw6661')}
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'renturn Book not found when isbn do not exsist' do
      put '/books/isbnnil',
          params:{isbn: 'isbn3', author: 'author3', price: 3, img_url: 'Url3', description:  'Description3'},
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'update the book information and you can get updated information when update succeed' do
      put '/books/isbn1',
          params:{isbn: 'isbn3', author: 'author3', price: 3, img_url: 'Url3', description:  'Description3'},
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include('Book updated')
      expect(response.status).to eql 202

      get '/books/isbn1',
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to eq \
            "{\"name\":\"name1\",\"isbn\":\"isbn1\",\"author\":\"author1\",\"price\":3,\"img_url\":\"Url3\",\"description\":\"Description3\"}"
      expect(response.status).to eql 200
    end
  end

  describe 'DELETE#delete'do

    it 'return login error 401 when DELETE#delete with wrong login msg' do
      delete '/books/isbnnil',
           env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw6661')}
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'renturn Book not found when isbn do not exsist' do
      delete '/books/isbnnil',
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'delete the book information and you can not get deleted information anymore' do
      delete '/books/isbn1',
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include('Book delete succeed!')
      expect(response.status).to eql 200

      get '/books/isbn1',
          env:{ :HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end
  end

end

DatabaseCleaner.clean
