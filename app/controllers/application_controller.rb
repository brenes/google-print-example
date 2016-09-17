class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_google_cloud

  def authenticate_google_cloud
    @google_client = CloudPrint::Client.new(
      refresh_token: Rails.application.secrets.google_refresh_token,
      client_id: Rails.application.secrets.google_client_id,
      client_secret:  Rails.application.secrets.google_client_secret
    )
  end
end
