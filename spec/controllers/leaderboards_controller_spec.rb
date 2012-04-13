require 'spec_helper'

describe LeaderboardsController do

  describe "GET 'players'" do
    it "returns http success" do
      get 'players'
      response.should be_success
    end

    it "should return 10 players" do
      (1..11).each do |n|
        player = Player.create(:first_name => "player#{n}",
                               :last_name => "name",
                               :email => "player#{n}@email.com",
                               :mobile_number => "123",
                               :city => "Melbourne",
                               :company_name => "TW",
                               :role => "dev")

        Timer.create(:player_id => player.id,
                     :time_seconds => 0.01 + n.to_f)
      end

      get 'players'
      assigns(:players).length.should == 10
    end

    it "should order players by fastest times" do
      [ [ 1, 1.7 ],
        [ 2, 0.5 ],
        [ 3, 2.5 ] ].each do |player_number, time_used|

          player = Player.create(:first_name => "player#{player_number}",
                                  :last_name => "name",
                                  :email => "player#{player_number}@email.com",
                                  :mobile_number => "123",
                                  :city => "Melbourne",
                                  :company_name => "TW",
                                  :role => "dev")
          Timer.create(:player_id => player.id, :time_seconds => time_used)
        end

      get 'players'
      assigns(:players)[0].should == Player.find_by_first_name("player2")
      assigns(:players)[1].should == Player.find_by_first_name("player1")
      assigns(:players)[2].should == Player.find_by_first_name("player3")
    end

  end

end
