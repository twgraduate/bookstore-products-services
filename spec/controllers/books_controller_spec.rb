require 'rails_helper'

describe BooksController do



  describe "POST #create" do
    let(:invalid_params_error_message){ "invalid params" }
    let(:add_book_successful){ "Create a new book" }

    it 'returns invalid params error message and 500 error code when name is empty' do
      allow(Book).to receive(:new).and_raise(ArgumentError, invalid_params_error_message)
      post :create, {}
      expect(response.body).to include invalid_params_error_message
      expect(response.status).to eql 500
    end

    it 'returns Create a new book successfukl message and 201 response code when post successful' do
      allow(Book).to receive(:new)
      allow(BooksHelper).to receive(:add)
      post :create, {}
      expect(response.body).to include add_book_successful
      expect(response.status).to eql 201
    end
  end

end