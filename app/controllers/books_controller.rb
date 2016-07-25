class BooksController < ApplicationController

  before_action :check_logged_in, only: [:create, :update]

  before_action :set_book, only: [:update]

  def index
    @books=Book.all
    render :json => @books
  end


  def create
    @book = Book.new(post_params)
    if BooksHelper.save(@book)
      render :json => {'msg': 'Create a new book','code': '201'}, status: 201
    else
      render :json => {'msg':"#{@book.errors.values.join("; ")}",'code':'409'}, status: 409
    end
  end


  def update
    if @book = @book.update(put_params)
      render :json => {'msg': 'Book updated','code': '202'}, status: 202
    else
      render :json => @book.errors, status: 409
    end

  end


  private

    def set_book
      @book = Book.find_by_isbn(params[:isbn])
    rescue ActiveRecord::RecordNotFound
      render :json =>{'msg':'Book not found','code':'404'} , :status => 404
    end

    def post_params
      params.permit(:name, :author, :isbn, :price, :img_url, :description)
    end

    def put_params
      params.permit(:price,:img_url,:description)
    end

    def check_logged_in
      authenticate_or_request_with_http_basic('Books',message = {"msg"=>"username or password is error",'code':"401"}.to_json) do |username,password|
        username == 'admin' && password =='tw666'
    end

    end
    #

#{book=>{name:hda,price:dhaj}}

end
