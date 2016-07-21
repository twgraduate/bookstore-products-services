require 'rails_helper'

describe Book do

  describe 'initialize' do
    let(:name_empty_message){'Book name can not be empty'}

    it "returns name error when name is empty " do
      post :create, {}
      expect(response.body).to include name_empty_message
      expect(response.status).to eql 500
    end
  end

end
