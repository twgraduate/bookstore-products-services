class BooksController < ApplicationController
#
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books.json
  def index
    @books = Book.all
    render :json => @books.to_json
  end

  # GET /books/1.json
  def show
    render :json => @book.to_json
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    if @book.save
      render :json =>{'msg'=>'book saved!'},status: :created
    else
      render :json => @book.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render :json =>{'msg'=>'book updated!'},status: :accepted
    else
      render :json => @book.errors,status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    render :json =>{'msg'=>'book destroyed!'},status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :json =>{'msg'=>'Book not found','code'=>'404'} , :status => 404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:name, :isbn, :author, :price, :img_url, :description)
  end

end
