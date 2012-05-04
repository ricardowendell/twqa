class CreateAttemptedQuestions < ActiveRecord::Migration
  def change
    create_table :attempted_questions, :id => false do |t|
      t.integer :question_id
      t.integer :player_id
      t.boolean :answered_correctly

      t.timestamps
    end
  end
end
