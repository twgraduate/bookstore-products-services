require "rails_helper"

RSpec.describe VersionsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an version number" do
      get :index
      expect(response).to be_success
    end
  end
end