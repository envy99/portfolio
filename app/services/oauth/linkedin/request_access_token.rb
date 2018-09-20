class Oauth::Linkedin::RequestAccessToken < ApplicationService
  attr_reader :code, :host_url, :api_key, :secret_api_key, :type

  def initialize(params)
    @code           = params[:code]
    @host_url       = ENV["host"]
    @api_key        = ENV["linkedin_api_key"]
    @secret_api_key = ENV["linkedin_secret_api_key"]
    @type           = "authorization_code"
  end

  def call
    response = RestClient.post("https://www.linkedin.com/oauth/v2/accessToken", build_params)
    JSON.parse(response)["access_token"]
  end

  private

  def build_params
    { grant_type: type, code: code, redirect_uri: redirect_url, client_id: api_key, client_secret: secret_api_key }
  end

  def redirect_url
    host_url + "/oauth/linkedin/fetch_user_data"
  end
end
