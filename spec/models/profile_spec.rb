require "rails_helper"

RSpec.describe Profile, type: :model do
  let(:profile) { FactoryBot.build(:profile) }

  describe "validation tests" do
    context "for name" do
      it { is_expected.to validate_presence_of(:name) }
    end

    it "should save successfully" do
      expect(profile.save).to eq(true)
    end
  end

  describe "association tests" do
    it { is_expected.to belong_to(:user).as_inverse_of(:profile) }
    it { is_expected.to embed_many(:sections) }
  end
end
