class AttemptedQuestion < ActiveRecord::Base
  set_primary_keys :question_id, :player_id

  has_one :question
  has_one :player

  validates_uniqueness_of :player_id, :scope => :question_id
  validates_presence_of :player_id, :question_id

  default_scope :order =>  "question_id ASC"
end
