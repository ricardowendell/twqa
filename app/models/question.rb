require 'csv'

class Question < ActiveRecord::Base

  def self.all_questions
    questions = Question.all.collect { |question| question.json_format }
    questions = load_questions_from_csv if questions.empty?
    questions
  end

  def self.load_questions_from_csv
    questions_file = File.expand_path(File.join("config", "questions-fisl.txt"))
    CSV.foreach(questions_file, {:col_sep => "\t"}) do |row|
      Question.create(:question => row[0], :correct_answer => row[1],
                      :incorrect_answer_1 => row[2], :incorrect_answer_2 => row[3]).json_format
    end
  end

  def json_format
    {:question_id => id,
     :question => question,
     :correct_choice => correct_answer,
     :choices => [correct_answer, incorrect_answer_1, incorrect_answer_2].sort_by { rand } }
  end

end
