class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question, :null => false
      t.string :correct_answer, :null => false
      t.string :incorrect_answer_1, :null => false
      t.string :incorrect_answer_2, :null => false
    end
  end
end