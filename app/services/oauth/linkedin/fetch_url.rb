class Oauth::Linkedin::FetchUrl < ApplicationService
  attr_reader :csrf_token, :host_url, :api_key, :request_link

  def initialize(params)
    @csrf_token   = params[:csrf_token]
    @host_url     = ENV["host"]
    @api_key      = ENV["linkedin_api_key"]
    @request_link = "https://www.linkedin.com/oauth/v2/authorization"
  end

  def call
    build_url
  end

  private

  def build_url
    "#{request_link}?response_type=code&client_id=#{api_key}&redirect_uri=#{redirect_url}&state=#{@csrf_token}"
  end

  def redirect_url
    host_url + "/oauth/linkedin/fetch_user_data"
  end
end
