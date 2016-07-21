require 'rails_helper'

describe Book do

  describe 'initialize' do

    let(:name_empty_message){'Book name can not be empty'}

    it "returns name error when name is empty" do
      initialize(paramas = {})
      expect(response).to raise_error(NameError)
    end
  end

end
