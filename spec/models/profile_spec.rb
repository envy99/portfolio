require "rails_helper"

RSpec.describe Profile, type: :model do
  describe "association tests" do
    it { is_expected.to be_embedded_in(:user).as_inverse_of(:profile) }
    it { is_expected.to embed_many(:sections) }
  end
end
