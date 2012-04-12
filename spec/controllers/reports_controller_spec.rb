require 'spec_helper'

describe ReportsController do
  let(:login) {
    @request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials('twqaadmin','password')
  }

  describe "GET 'index'" do
    it "returns http failure before login" do
      get 'index'
      response.should_not be_success
    end

    it "returns http success after login" do
      login
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'download'" do
    it "returns http failure before login" do
      get 'download'
      response.should_not be_success
    end

    it "returns http success after login" do
      login
      get 'download'
      response.should be_success
      response.headers['Content-Disposition'].should include 'filename="player_data.csv"'
      response.headers['Content-Type'].should include 'text/csv'
    end
  end

end
