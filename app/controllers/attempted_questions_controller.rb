class AttemptedQuestionsController < ApplicationController
  def record
    records = params[:attempted_questions]
    records.each do |index, record|
      AttemptedQuestion.find_or_create_by_question_id_and_player_id(:question_id => record[:question_id],
                                                                    :player_id => params[:player_id],
                                                                    :answered_correctly => record[:answered_correctly])
    end
    render :nothing => true
  end

  def correct
    render :nothing => true
  end
end
