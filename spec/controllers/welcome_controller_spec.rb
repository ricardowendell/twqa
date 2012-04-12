require 'spec_helper'

describe WelcomeController do
  describe '#registered' do
    it 'should create a player object' do
      get :registered
      assigns(:player).should be_an_instance_of(Player)
    end
  end
  
  describe '#login' do
    
    describe 'on valid criteria' do
      it 'should redirect to questions' do
        attributes = {email: "bm"}
        Player.stub(:where).with(:email => 'bm').and_return([Player.new(:email => 'bm')])
        post :login, :player => attributes

        response.should redirect_to('/questions')
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