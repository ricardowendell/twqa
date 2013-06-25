class QaController < ApplicationController

  def index
    
  end
  
  def questions
    @player_id = params[:player]
    respond_to do |format|
      format.json {render :json => Question.some_questions}
      format.html {render :action => 'index'}
    end
  end

end
