require 'rails_helper'

RSpec.describe "books/show", type: :view do
  before(:each) do
    @book = assign(:book, Book.create!(
      :name => "Name",
      :isbn => 2,
      :author => "Author",
      :price => "9.99",
      :img_url => "Img Url",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Img Url/)
    expect(rendered).to match(/MyText/)
  end
end
