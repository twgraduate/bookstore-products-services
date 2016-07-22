class BooksController < ApplicationController

#   before_action :check_logged_in, only: [:edit, :update, :destroy]
#   before_action :set_book, only: [:show, :edit, :update, :destroy]


  def create
    begin
      @book = Book.new(post_params)
      if BooksHelper.add(@book)
        render :json => {message: 'Create a new book'}, status: 201
      else
        render :json => @book.errors, status: 500
      end
    end
  end


  private
  # # Use callbacks to share common setup or constraints between actions.
  # def set_book
  #   @book = Book.find_by_isbn(params[:isbn])
  # rescue ActiveRecord::RecordNotFound
  #   render :json =>{'msg'=>'Book not found','code'=>'404'} , :status => 404
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.permit(:name, :author, :isbn, :price, :img_url, :description)
  end

# def put_params
#   params.permit(:price,:img_url,:description)
# end


# def check_logged_in
#   authenticate_or_request_with_http_basic('Books') do |username,password|
#     username == 'admin' && password =='tw666'
#   end
# end
#{book=>{name:hda,price:dhaj}}

end
