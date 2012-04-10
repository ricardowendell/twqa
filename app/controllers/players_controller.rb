class PlayersController < ApplicationController

  def new
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    if @player.save
      redirect_to questions_path
    else
      render new_player_path
    end
  end
end