class CreatePlayer < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :mobile_number, :null => false
      t.string :city, :null => false
      t.string :company_name, :null => false
      t.string :role, :null => false
    end
  end
end