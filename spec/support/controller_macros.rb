module ControllerMacros
  def authenticate
    @request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(APP_AUTH, LOCAL_PASSWORD)
  end
end
