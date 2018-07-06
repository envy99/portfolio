require "rails_helper"

RSpec.describe Profile, type: :model do
  describe "validation tests" do
    context "for name" do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe "association tests" do
    it { is_expected.to belong_to(:user).as_inverse_of(:profile) }
    it { is_expected.to embed_many(:sections) }
  end
end
