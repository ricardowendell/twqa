class QaController < ApplicationController

  def index
    
  end
  
  def questions
    respond_to do |format|
      format.json {render :json => Questions.all}
      format.html {render :action => 'index'}
    end
  end

end
