class WelcomeController < ApplicationController
  def welcome
    @player = Player.new
  end
  
  def registered
    @player = Player.new
  end
  
  def login
    email = params[:player][:email]
    players = Player.where(:email => email)
    unless players.empty?
      redirect_to questions_path(:player => players.first.id)
    else
      @player = Player.new(:email => email)
      @player.errors.add(:email, 'Email not found. Please register first.')
      render :welcome
    end
  end
end