require "rails_helper"

describe BooksController do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/books").to route_to("books#create")
    end

  end
end
