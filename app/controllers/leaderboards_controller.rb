class LeaderboardsController < ApplicationController
  def players
    @players = Player.joins(:timer).includes(:timer).find(:all, :limit => 10,
                                                          :order => "time_seconds ASC")
  end
  
  def player_position
    player_id = params[:player_id].to_i
    position = Timer.find_by_sql("select count(*) as position from timers where time_seconds < (select time_seconds from timers where player_id = #{player_id})").first.position.to_i + 1
    render :text => position
  end
end
