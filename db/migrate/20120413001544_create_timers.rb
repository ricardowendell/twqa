class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers, :id => false do |t|
      t.integer :player_id
      t.float :time_seconds

      t.timestamps
    end
  end
end
