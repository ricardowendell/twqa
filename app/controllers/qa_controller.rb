class QaController < ApplicationController

  def index
    
  end
  
  def questions
    @player_id = params[:player]
    respond_to do |format|
      format.json {render :json => Questions.all}
      format.html {render :action => 'index'}
    end
  end

end
