require 'rails_helper'

RSpec.describe "Books", type: :request do

  let(:book1){{name: 'name1', isbn: 'isbn1', author: 'author1', price: 1, img_url: 'Url1', description: 'Description1'}}
  let(:book2){{name: 'name2', isbn: 'isbn2', author: 'author2', price: 2, img_url: 'Url2', description:'Description2'}}
  let(:book3){{name: 'name1', isbn: 'isbn1', author: 'author1', price: 2, img_url: 'Url2', description:'Description2'}}
  let(:error_login_msg){{:HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw6661')}}
  let(:accurate_login_msg){{:HTTP_AUTHORIZATION => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'tw666')}}
  before(:each)do
    DatabaseCleaner.clean
  end

  describe 'POST#create' do

    it 'return login error 401 when POST#create wrong login msg' do
      post '/books',
           params:book1,
           env:error_login_msg
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'reject the params when data is invalidate' do
      post '/books',
           params:{isbn: 'isbn1', author: 'author1', price: 1, img_url: 'Url1', description:  'Description1'},
           env:accurate_login_msg
      expect(response.body).to include ('Name can not be empty')
      expect(response.status).to eql 409
      expect(response.content_type).to eq("application/json")
    end

    it 'post the data into the sql when data is validate' do
      post '/books',
           params:book1,
           env:accurate_login_msg
      expect(response.body).to include ('Create a new book')
      expect(response.status).to eql 201
      expect(response.content_type).to eq("application/json")
    end

  end

  describe 'GET#index' do
    it 'returns the book list that you have posted' do
      post '/books',
           params:book1,
           env:accurate_login_msg
      post '/books',
           params:book2,
           env:accurate_login_msg
      get '/books',
          env:accurate_login_msg
      expect(response.content_type).to eq("application/json")
      expect(response.body).to eq [book1,book2].to_json
    end
  end


  describe 'GET#show' do

    it 'renturn Book not found when isbn do not exsist' do
      get '/books/isbn1'
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'return the book message when book is found depends on isbn' do
      post '/books',
           params:book1,
           env:accurate_login_msg
      get '/books/isbn1'
      expect(response.body).to eql book1.to_json
      expect(response.status).to eql 200
    end
  end

  describe 'PUT#update' do

    it 'return login error 401 when PUT#update with wrong login msg' do
      put '/books/isbn1',
          params:book1,
          env:error_login_msg
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'renturn Book not found when isbn do not exsist' do
      put '/books/isbnnil',
          params:book1,
          env:accurate_login_msg
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'update the book information and you can get updated information when update succeed' do
      post '/books',
           params:book1,
           env:accurate_login_msg
      put '/books/isbn1',
          params:book2,
          env:accurate_login_msg
      expect(response.body).to include('Book updated')
      expect(response.status).to eql 202
      get '/books/isbn1',
          env:accurate_login_msg
      expect(response.body).to eq book3.to_json
      expect(response.status).to eql 200
    end
  end

  describe 'DELETE#delete'do

    it 'return login error 401 when DELETE#delete with wrong login msg' do
      delete '/books/isbnnil',
           env:error_login_msg
      expect(response.body).to include ("username or password is error")
      expect(response.status).to eql 401
    end

    it 'renturn Book not found when isbn do not exsist' do
      delete '/books/isbn1',
          env:accurate_login_msg
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end

    it 'delete the book information and you can not get deleted information anymore' do
      post '/books',
           params:book1,
           env:accurate_login_msg
      delete '/books/isbn1',
          env:accurate_login_msg
      expect(response.body).to include('Book delete succeed!')
      expect(response.status).to eql 200
      get '/books/isbn1'
      expect(response.body).to include('Book not found')
      expect(response.status).to eql 404
    end
  end

end

