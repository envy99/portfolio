class Oauth::MergeUserController < ApplicationController
  before_action :linkedin_id_nil?

  def new
    @email = session[:linkedin_api_response]["emailAddress"]
    @user  = User.where(email: @email).first
    @oauth_provider = "Linkedin"
  end

  def create
    user = User.where(email: session[:linkedin_api_response]["emailAddress"]).first
    if user.valid_password?(params[:user][:password])
      user.update(update_params)
      sign_in(:user, user)
      flash[:notice] = "Welcome! You have signed up using Linkedin."
      redirect_to root_path
    else
      redirect_to new_oauth_merge_user_path
      flash[:alert] = "Your password isn't correct."
    end
  end

  private

  def permitted(params)
    params.require(:user).permit(:password)
  end

  def update_params
    { linkedin_id: session[:linkedin_api_response]["id"], linkedin_access_token: session[:linkedin_access_token] }
  end

  def linkedin_id_nil?
    redirect_to root_path if User.where(email: session[:linkedin_api_response]["emailAddress"]).first.try(:linkedin_id)
  end
end
