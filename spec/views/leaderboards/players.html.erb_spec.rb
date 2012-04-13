require 'spec_helper'

describe "leaderboards/players.html.erb" do
  before(:each) do
    player = Player.create(:first_name => "Teddy",
                           :last_name => "Panda",
                           :email => "teddypanda@email.com",
                           :mobile_number => "123",
                           :city => "Melbourne",
                           :company_name => "Happy Zoo",
                           :role => "dev")

    Timer.create(:player_id => player.id, :time_seconds => 1.28866)
  end

  it "should display first name, last name and company" do
    assign :players, Player.all

    render
    rendered.should have_content("Teddy Panda")
    rendered.should have_content("Happy Zoo")
  end

  it "should display time in seconds with three decimal places" do
    assign :players, Player.all

    render
    rendered.should have_content("1.289")
  end
end
