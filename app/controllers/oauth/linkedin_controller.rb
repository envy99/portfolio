class Oauth::LinkedinController < ApplicationController
  before_action :validate_request, only: :fetch_user_data
  before_action :generate_csrf, only: :fetch_authorization_code

  def fetch_authorization_code
    redirect_to Oauth::Linkedin::FetchUrl.call(csrf_token: session[:linkedin_csrf])
  end

  def fetch_user_data
    session[:linkedin_access_token] = fetch_access_token
    @api_user = Oauth::Linkedin::RequestUserLoginData.call(access_token: session[:linkedin_access_token])
    login_or_create
  end

  private

  def fetch_access_token
    Oauth::Linkedin::RequestAccessToken.call(code: params["code"])
  end

  def login_or_create
    if user = User.where(linkedin_id: @api_user["id"]).first
      login_user(user)
    else
      create_linkedin_user
    end
  end

  def create_linkedin_user
    session[:linkedin_api_response] = @api_user
    if User.where(email: @api_user["emailAddress"]).any?
      merge_linkedin_to_account
    else
      register_user
    end
  end

  def validate_request
    if params["state"] != session[:linkedin_csrf]
      render_unauthorized
    elsif params["error"] && params["state"] == session[:linkedin_csrf]
      handle_error
    end
  end

  def merge_linkedin_to_account
    redirect_to new_oauth_merge_user_path
  end

  def generate_csrf
    session[:linkedin_csrf] = SecureRandom.hex
  end

  def register_user
    redirect_to new_oauth_user_path
  end

  def login_user(user)
    sign_in(:user, user)
    flash[:notice] = "Signed in using Linkedin."
    redirect_to root_path
  end

  def handle_error
    flash[:notice] = "You have canceled login."
    redirect_to new_user_session_path
  end

  def render_unauthorized
    render file: "public/401.html", status: :unauthorized
  end
end
