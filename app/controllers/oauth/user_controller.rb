class Oauth::UserController < ApplicationController
  before_action :user_not_exists?

  def new
    @email = session[:linkedin_api_response]["emailAddress"]
    @user  = User.new
  end

  def create
    user = permitted(params)
    user[:linkedin_id] = session[:linkedin_api_response]["id"]
    user[:linkedin_access_token] = session[:linkedin_access_token]
    user[:email] = session[:linkedin_api_response]["emailAddress"]
    return false unless created_user = User::Create.call(user: user)
    sign_in_user(created_user)
  end

  private

  def sign_in_user(created_user)
    sign_in(:user, created_user)
    flash[:notice] = "Welcome! You have signed up using Linkedin."
    redirect_to root_path
  end

  def permitted(params)
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_not_exists?
    redirect_to root_path if User.where(email: session[:linkedin_api_response]["emailAddress"]) != []
  end
end
