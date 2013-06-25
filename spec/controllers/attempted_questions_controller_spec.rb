require 'spec_helper'

describe AttemptedQuestionsController do
  before(:each) do
    authenticate
  end

  describe "#record'" do
    it "should store the attempt record" do
      log = {"0" => {"question_id" => 1, "answered_correctly" => false} }
      post_data = {player_id: 4, attempted_questions:log }
      AttemptedQuestion.should_receive(:find_or_create_by_question_id_and_player_id).with(:question_id => 1.to_s,
                                                                                          :player_id => 4.to_s,
                                                                                          :answered_correctly => false)
      post :record, post_data
    end

    it "should loop through all the record" do
      log = {}
      (1..5).each do |i|
        log[i] = {"question_id" => i, "answered_correctly" => false}
      end
      post_data = {player_id: 333, attempted_questions: log}
      AttemptedQuestion.should_receive(:find_or_create_by_question_id_and_player_id).exactly(5).times

      post :record, post_data
    end
  end

  describe "#correct" do
    it "should receive the responses" do
      log = {"0" => {"question_id" => 1, "answer" => "a silly answer"} } 
      post_data = {player_id: 1, attempted_questions: log} 
      post :correct, post_data
    end
  end
end
