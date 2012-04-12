require 'spec_helper'

describe PlayersController do
  describe '#new' do
    it 'should create a player object' do
      get :new
      assigns(:player).should be_an_instance_of(Player)
    end
  end
  
  describe '#create' do
    describe 'on valid criteria' do
      it 'should redirect to questions' do
        valid_attributes = {first_name: "a", last_name: "b", 
                            email: "bm@fake.com", mobile_number: "m",
                            city: "Darwin", company_name: "lk",
                            role: "Developer"}

        post :create, :player => valid_attributes

        response.should redirect_to('/questions')
      end
    end
    
    describe 'on invalid criteria' do
      it 'should render' do
        invalid_attributes = {:first_name => 'abcd'}

        post :create, :player => invalid_attributes

        assigns(:player).first_name.should == 'abcd'
        response.should render_template(:new)
      end
    end
  end
end