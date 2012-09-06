require 'spec_helper'

describe Timer do
  
  it "should not accept negative time" do
    invalid_timer = Timer.new :time_seconds => -1
    invalid_timer.should_not be_valid
  end
  
  
end
