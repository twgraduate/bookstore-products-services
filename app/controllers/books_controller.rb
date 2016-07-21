class BooksController < ApplicationController
# #
#   before_action :check_logged_in, only: [:edit, :update, :destroy]
#   before_action :set_book, only: [:show, :edit, :update, :destroy]
#


  def create
    begin
      BooksHelper.add Book.new(params)
      render :json => { message: 'Create a new book'}, status: 201
    rescue ArgumentError => e
      render :json => { message: e.message}, status: 500
    end
    #
    # if @book.save
    # #   render :json =>{'msg'=>'book saved!'},status: :created
    # # else
    # #   render :json => @book.errors,status: :conflict
    # end
    # # render :json => { message: 'invalid params'}, status: 201
  end


  private
  # # Use callbacks to share common setup or constraints between actions.
  # def set_book
  #   @book = Book.find_by_isbn(params[:isbn])
  # rescue ActiveRecord::RecordNotFound
  #   render :json =>{'msg'=>'Book not found','code'=>'404'} , :status => 404
  # end

  # # Never trust parameters from the scary internet, only allow the white list through.
  # def book_params
  #   params.require(:book).permit(:name, :isbn, :author, :price, :img_url, :description)
  # end

  # def check_logged_in
  #   authenticate_or_request_with_http_basic('Books') do |username,password|
  #     username == 'admin' && password =='tw666'
  #   end
  # end

end
