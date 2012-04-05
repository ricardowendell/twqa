class Player < ActiveRecord::Base
  validates :first_name, :last_name, :email, :mobile_number, :city, :company_name, :role, :presence => {:message => 'required'}
end