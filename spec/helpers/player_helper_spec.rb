require 'spec_helper'

describe 'player helper' do
  describe 'cities' do
    it 'should be a list' do
      PlayerHelper::cities.should be_an_instance_of(Array) 
    end
  end
  
  describe 'roles' do
    it 'should be a list' do
      PlayerHelper::roles.should be_an_instance_of(Array) 
    end
  end
end