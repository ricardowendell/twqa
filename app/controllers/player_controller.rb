class PlayerController < ApplicationController

  def players
    # client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "root")
    #     results = client.query("SELECT 1 FROM dual")
    #     results.each(:as => :array) do |result|
    #       # puts result.to_s
    #     end
    players = Player.all
    players.each do |p|
      puts p.name
    end
    render :text => "awesome"
  end

end