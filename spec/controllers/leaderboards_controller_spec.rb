require 'spec_helper'

describe LeaderboardsController do

  describe "GET 'players'" do
    it "returns http success" do
      get 'players'
      response.should be_success
    end
  end

end
