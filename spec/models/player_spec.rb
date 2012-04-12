require 'spec_helper'

describe Player do
  describe "csv_data" do
    it "should parse player data to csv format" do
      player = Player.create(:first_name => "cool",
                             :last_name => "kid",
                             :email => "coolkid@example.com",
                             :mobile_number => "1234567",
                             :city => "Melbourne",
                             :company_name => "TW",
                             :role => "cleaner" )

      expected_string = <<-data
FIRST_NAME,LAST_NAME,EMAIL,MOBILE_NUMBER,CITY,COMPANY_NAME,ROLE
cool,kid,coolkid@example.com,1234567,Melbourne,TW,cleaner
      data
      Player.csv_data.should == expected_string
    end
  end
end
