require "rails_helper"

describe BooksController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => '/books').to route_to('books#index')
    end
    it "routes to #create" do
      expect(:post => "/books").to route_to("books#create")
    end
    it "routes to #update" do
      expect(:put =>'/books/:isbn').to route_to(:controller => 'books', :action=>'update',:isbn=>':isbn')
    end
    it "routes to show" do
      expect(:get =>'/books/:isbn').to route_to(:controller => 'books', :action=>'show',:isbn=>':isbn')
    end

    it "routes to delete" do
      expect(:delete => '/books/:isbn').to route_to(:controller => 'books', :action=>'delete',:isbn=>':isbn')
    end

  end
end
