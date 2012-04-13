class LeaderboardsController < ApplicationController
  def players
    @players = Player.joins(:timer).includes(:timer).find(:all, :limit => 10,
                                                          :order => "time_seconds ASC")
  end

end
