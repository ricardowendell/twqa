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
  
  describe '.player_position' do
    before(:each) do
      Timer.delete_all
    end
    it 'should get position based on time' do
      Timer.create(:player_id => 2, :time_seconds => 4)
      Timer.create(:player_id => 1, :time_seconds => 6)
      
      get 'player_position', :player_id => 1
      response.body.should == '2'
      
      get 'player_position', :player_id => 2
      response.body.should == '1'
    end
  end

end
