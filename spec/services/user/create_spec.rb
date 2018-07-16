require "rails_helper"

RSpec.describe User::Create do
  let(:sign_up_params) { attributes_for(:user) }
  let(:user) { User.first }
  let(:profile_user) { Profile.first.user }

  subject { described_class }

  it "creates user and associated profile" do
    expect {
      subject.call(user: sign_up_params)
    }.to change {
      User.count
    }.from(0).to(1)
    expect(profile_user).to eq(user)
  end

  it "should not create profile if user not saved" do
    allow_any_instance_of(subject).to receive_message_chain("user.save") { false }
    subject.call(user: sign_up_params)
    expect(Profile.count).to eq(0)
  end
end
