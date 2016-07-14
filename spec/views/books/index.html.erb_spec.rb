require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        :name => "Name",
        :isbn => 2,
        :author => "Author",
        :price => "9.99",
        :img_url => "Img Url",
        :description => "MyText"
      ),
      Book.create!(
        :name => "Name",
        :isbn => 2,
        :author => "Author",
        :price => "9.99",
        :img_url => "Img Url",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Img Url".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
