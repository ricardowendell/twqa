require 'spec_helper'

describe QaController do
  describe 'questions' do
    it 'should return questions in json format' do
      Question.should_receive(:all_questions)
      get :questions, :player => 1, :format => :json
    end
  end
end
