class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_google_cloud

  def authenticate_google_cloud
    @google_client = CloudPrint::Client.new(
      client_id: Rails.application.secrets.google_client_id,
      client_secret:  Rails.application.secrets.google_client_secret
    )

    if session[:refresh_token]
      # Actually nothing..
    elsif params[:code]
      token = @google_client.oauth_client.auth_code.get_token(params[:code], redirect_uri: prints_url)
      # when the user has already given permission, it's already refreshed!
      if token.refresh_token
        token.refresh!
      end
      session[:refresh_token] = token.token
      redirect_to prints_url
    else
      redirect_to @google_client.auth.generate_url(prints_url)
    end

    if session[:refresh_token]
      @refresh_token = session[:refresh_token]

      @google_client = CloudPrint::Client.new(
        refresh_token: @refresh_token,
        client_id: Rails.application.secrets.google_client_id,
        client_secret:  Rails.application.secrets.google_client_secret
      )
    end
  end
end
