require "rails_helper"

RSpec.describe Section, type: :model do
  let(:section) { FactoryBot.build(:section) }

  describe "validation tests" do
    context "for name" do
      it { is_expected.to validate_presence_of(:name) }
    end

    it "should save successfully" do
      expect(section.save).to eq(true)
    end
  end

  describe "association tests" do
    it { is_expected.to be_embedded_in(:profile).as_inverse_of(:sections) }
    it { is_expected.to embed_many(:items) }
  end
end
