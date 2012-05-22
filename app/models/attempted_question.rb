class AttemptedQuestion < ActiveRecord::Base
  set_primary_keys :question_id, :player_id

  has_one :question
  has_one :player

  validates_uniqueness_of :player_id, :scope => :question_id
  validates_presence_of :player_id, :question_id

  default_scope :order =>  "question_id ASC"
  
  def self.csv_data
    CSV.generate do |csv|
      
      question_and_attempts = AttemptedQuestion.find(
        :all,
        :select => 'question_id, answered_correctly'
      )
      
      questions_with_counts = {}
      question_and_attempts.each do |question_and_attempt|
        correct = question_and_attempt.attributes['answered_correctly'] == true
        if(!questions_with_counts.has_key?(question_and_attempt.attributes['question_id'])) 
          true_count = 0
          if correct == true 
            true_count = 1
          end
          questions_with_counts[question_and_attempt.attributes['question_id']] = [true_count,1]
        else
          true_count = questions_with_counts[question_and_attempt.attributes['question_id']][0]
          true_count = true_count + 1 unless correct == false 
          
          total_count = questions_with_counts[question_and_attempt.attributes['question_id']][1]
          questions_with_counts[question_and_attempt.attributes['question_id']] = [true_count, total_count + 1]
        end 
      end
      
      question_with_percent_correct = {}
      questions_with_counts.keys.each do |question_id|
        percentage_correctly_answered = questions_with_counts[question_id][0].to_f/questions_with_counts[question_id][1].to_f * 100.0
        question_with_percent_correct[question_id] = percentage_correctly_answered.to_i
      end 
      
      csv << ['QUESTION','PERCENTAGE_CORRECT_FIRST_ATTEMPT']
      
      question_with_percent_correct.keys.each do |question_id|
        question = Question.find(:first, :conditions => ["id=?", question_id])
        csv << [question.attributes['question'], question_with_percent_correct[question_id].to_s]
      end
    end
  end
  
end
