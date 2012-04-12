class ReportsController < ApplicationController
  before_filter :authenticate

    def index
    end

    def download
      player_csv_file
    end

  protected

    def player_csv_file
      send_data Player.csv_data,
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
