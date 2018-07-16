class User::Create < ApplicationService
  def initialize(params)
    @params = params[:user]
  end

  def call
    self.user = build_user
    create_profile if user.save
    user
  end

  private

  attr_accessor :user
  attr_reader   :params

  def create_profile
    Profile.create!(user_id: user.id, name: user.username)
  end

  def build_user
    User.new(params)
  end
end
