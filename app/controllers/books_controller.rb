class BooksController < ApplicationController

  before_action :check_logged_in, only: [:create, :update, :delete]
  before_action :set_book, only: [:update, :show, :delete]

  def create
    @book = Book.new(post_params)
    if @book.save
      render :json => {'msg': 'Create a new book'}, status: 200
    else
      render :json => {'msg': "#{@book.errors.values.join('; ')}"}, status: 400
    end
  end

  def index
    @books=Book.select('name,isbn,author,price,img_url,description')
    render :json => @books
  end

  def show
    render :json => @book, status: 200
  end

  def update
    @book.update(put_params)
    render :json => {'msg': 'Book updated!'}, status: 200
  end

  def delete
    @book.destroy
    render :json => {'msg': 'Book delete succeed!'}, :status => 200
  end

  private

  def set_book
    @book = Book.select('name,isbn,author,price,img_url,description').find_by_isbn(params[:isbn])
    if @book == nil
      render :json => {'msg': 'Book not found'}, :status => 404
    end
  end

  def post_params
    params.permit(:name, :author, :isbn, :price, :img_url, :description)
  end

  def put_params
    params.permit(:price, :img_url, :description)
  end

  def check_logged_in
    authenticate_or_request_with_http_basic('Books', message = {'msg': 'username or password is error'}.to_json) do |username, password|
      username == 'admin' && password =='tw666'
    end

  end

end
