require 'spec_helper'

describe TimersController do

  describe '#record' do
    describe 'no record exists' do
      it 'should store time' do
        valid_attributes = {player_id: 7, time_seconds: 1.2}
        Timer.should_receive(:where).with(:player_id => 7).and_return([])
        Timer.should_receive(:create).with(valid_attributes)
        post :record, valid_attributes
      end
    end
    
    describe 'faster record exists' do
      it 'should not store time' do
        valid_attributes = {player_id: 7, time_seconds: 1.2}
        Timer.should_receive(:where).with(:player_id => 7).and_return([Timer.new(:player_id => 7, :time_seconds => 0.5)])
        Timer.should_not_receive(:create)
        Timer.should_not_receive(:update_attributes)
        post :record, valid_attributes
      end
    end
    
    describe 'slower record exists' do
      it 'should store time' do
        valid_attributes = {player_id: 8, time_seconds: 2.03}
        mock_timer = mock(Timer)
        mock_timer.should_receive(:time_seconds).and_return(5.5)
        mock_timer.should_receive(:time_seconds=).with(2.03)
        mock_timer.should_receive(:save)
        Timer.should_receive(:where).with(:player_id => 8).and_return([mock_timer])
        Timer.should_not_receive(:create)
        post :record, valid_attributes
      end
    end
  end
end
