class SetupController < ActionController::Base
  protect_from_forgery with: :exception

  def show
    @google_client = CloudPrint::Client.new(
      client_id: Rails.application.secrets.google_client_id,
      client_secret:  Rails.application.secrets.google_client_secret
    )

    if Rails.application.secrets.google_refresh_token
      # Actually nothing..
    elsif params[:code]
      @token = @google_client.oauth_client.auth_code.get_token(params[:code], redirect_uri: root_url)
    else
      redirect_to @google_client.auth.generate_url(root_url)
    end
  end
end
