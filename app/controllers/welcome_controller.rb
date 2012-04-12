class WelcomeController < ApplicationController
  def welcome
  end
  
  def registered
    @player = Player.new
  end
  
  def login
    email = params[:player][:email]
    unless Player.where(:email => email).empty?
      redirect_to questions_path
    else
      @player = Player.new(:email => email)
      render :registered
    end
  end
end