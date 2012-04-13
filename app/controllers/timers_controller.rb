class TimersController < ApplicationController
  def record
    player_id, time = params[:player_id].to_i, params[:time_seconds].to_d
    timer = Timer.where(:player_id => player_id).first
    
    if timer.nil?
      Timer.create(:player_id => player_id, :time_seconds => time)
    elsif timer.time_seconds > time
      timer.time_seconds = time
      timer.save
    end
         
    render :nothing => true
  end
end
