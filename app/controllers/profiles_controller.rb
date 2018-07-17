class ProfilesController < ApplicationController
  before_action :set_profile, except: %i(index)
  before_action :authenticate_user!, except: %i(index show)
  before_action :check_owner!, except: %i(index show)

  def index
    @profiles = Profile.all
  end

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    if @profile.destroy
      redirect_to profiles_path, notice: "Profile deleted successfully!"
    else
      redirect_to @profile, alert: "Could not delete the profile!"
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(
      :name,
      sections_attributes: %i(id _destroy name)
    )
  end

  def check_owner!
    redirect_to profiles_path, alert: "You do not own this profile!" if @profile.user != current_user
  end
end
