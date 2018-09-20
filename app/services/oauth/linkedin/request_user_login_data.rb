class Oauth::Linkedin::RequestUserLoginData < ApplicationService
  attr_reader :access_token, :data, :main_link

  def initialize(params)
    @access_token = params[:access_token]
    @data         = "id,email-address"
    @main_link    = "https://api.linkedin.com/v1/people"
  end

  def call
    response = RestClient.get("#{main_link}/~:(#{data})?&oauth2_access_token=#{access_token}&format=json")
    JSON.parse(response)
  end
end
