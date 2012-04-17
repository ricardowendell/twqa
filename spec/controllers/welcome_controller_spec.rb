require 'spec_helper'

describe WelcomeController do
  before(:each) do
    authenticate
  end

  describe '#registered' do
    it 'should create a player object' do
      get :registered
      assigns(:player).should be_an_instance_of(Player)
    end
  end

  describe '#login' do

    describe 'on valid criteria' do
      it 'should redirect to questions' do
        player = Player.new(:email => 'bm')
        player.id = 11
        attributes = {email: "bm"}
        Player.stub(:where).with(:email => 'bm').and_return([player])
        post :login, :player => attributes

        response.should redirect_to('/questions/11')
      end
    end

    describe 'on invalid criteria' do
      it 'should render' do
        attributes = {:email => 'ascd'}
        Player.stub(:where).with(:email => 'ascd').and_return([])
        post :login, :player => attributes

        assigns(:player).email.should == 'ascd'
        response.should render_template(:registered)
      end
    end
  end
end
