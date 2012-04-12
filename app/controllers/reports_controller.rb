require 'csv'

class ReportsController < ApplicationController
  before_filter :authenticate

    def index
    end

    def download
      player_csv_data
    end

  protected

    def player_csv_data
      csv_string = CSV.generate do |csv|
        csv << ["id",
                "First name",
                "Last name",
                "Email",
                "Mobile number",
                "City",
                "Company name",
                "Role"]

          Player.find(:all).each do |player|
            csv << [player.id,
                    player.first_name,
                    player.last_name,
                    player.email,
                    player.mobile_number,
                    player.city,
                    player.company_name,
                    player.role ]
          end
      end

      send_data csv_string,
                :type => 'text/csv; charset=iso-8859-1; header=present',
                :filename => 'player_data.csv'
    end

    #TODO: move user name and password to config?
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        actual_password = ENV['ADMIN_PASSWORD'] || 'password'
        username == "twqaadmin" && password == actual_password
      end
    end
end
