require 'rails_helper'

RSpec.describe "books/edit", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :name => "MyString",
      :isbn => 1,
      :author => "MyString",
      :price => "9.99",
      :img_url => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit book form" do
    render

    assert_select "form[action=?][method=?]", book_path(@book), "post" do

      assert_select "input#book_name[name=?]", "book[name]"

      assert_select "input#book_isbn[name=?]", "book[isbn]"

      assert_select "input#book_author[name=?]", "book[author]"

      assert_select "input#book_price[name=?]", "book[price]"

      assert_select "input#book_img_url[name=?]", "book[img_url]"

      assert_select "textarea#book_description[name=?]", "book[description]"
    end
  end
end
