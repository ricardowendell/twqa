require 'spec_helper'

describe QaController do
  describe 'questions' do
    before(:each) do
      authenticate
    end
    it 'should return questions in json format' do
      Question.should_receive(:all_questions)
      get :questions, :player => 1, :format => :json
    end
  end

  describe "GET 'questions'" do
    let(:player) do
      Player.create(:first_name => "Ali",
                    :last_name => "Baba",
                    :email => "alibaba@disney.com",
                    :mobile_number => 123,
                    :city => "Melbourne",
                    :company_name => "Disney",
                    :role => "Magician")
    end

    it "should return http failure before application authentication" do
      get :questions, {:player => player}
      response.should_not be_successful
    end

    it "should return http success after application authentication" do
      authenticate
      get :questions, {:player => player}
      response.should be_successful
    end
  end

end
