class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :app_authentication

  protected

    def app_authentication
      authenticate_or_request_with_http_basic do |username, password|
        actual_password = ENV['APP_PASSWORD'] || LOCAL_PASSWORD
        username == APP_AUTH && password == actual_password
      end
    end
end
