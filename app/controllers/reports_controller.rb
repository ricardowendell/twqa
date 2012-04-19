class ReportsController < ApplicationController
  skip_filter :app_authentication, :only => :download
  before_filter :admin_authentication, :only => :download

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

    def admin_authentication
      authenticate_or_request_with_http_basic do |username, password|
        actual_password = ENV['ADMIN_PASSWORD'] || LOCAL_PASSWORD
        username == ADMIN_AUTH && password == actual_password
      end
    end
end
