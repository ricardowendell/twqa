class Timer < ActiveRecord::Base
  belongs_to :player
  set_primary_key "player_id"
  
  validates_numericality_of :time_seconds, :greater_than => 0
  

  def self.attributes_protected_by_default
    ["created_at", "updated_at"]
  end
  
end
