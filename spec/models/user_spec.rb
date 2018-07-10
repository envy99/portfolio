require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "validation tests" do
    it "should save successfully" do
      expect(user.save).to eq(true)
    end
  end

  describe "association tests" do
    it { is_expected.to have_one(:profile).with_dependent(:destroy) }
  end
end
