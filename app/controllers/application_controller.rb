class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :show_books_error404
  def show_books_error404
    render :template => "/books/error404.html.erb", :status => 404
  end
  rescue_from :with => :show_books_error500
  def show_books_error500
    render :template => "/books/error500.html.erb", :status => 500
  end
end
