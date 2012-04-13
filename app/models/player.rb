require 'csv'

class Player < ActiveRecord::Base
  validates :first_name, :last_name, :email, :mobile_number, :city, :company_name, :role, :presence => {:message => 'required'}
  validates :email, :uniqueness => {:message => 'email already registered'}, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => 'invalid email'}, :presence => {:message => 'required'}

  has_one :timer

  def self.csv_data
    CSV.generate do |csv|
      csv << Player.column_names.drop(1).map {|field| field.upcase }

        Player.find(:all).each do |player|
          csv << player.attributes.values.drop(1)
        end
    end

  end
end
