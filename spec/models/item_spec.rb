require "rails_helper"

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.build(:item) }
  let(:text) { FactoryBot.build(:item, :text) }
  let(:image) { FactoryBot.build(:item, :image) }

  describe "validation tests" do
    context "for content" do
      it { is_expected.to validate_presence_of(:content) }
    end

    it "should save successfully" do
      expect(item.save).to eq(true)
      expect(text.save).to eq(true)
      expect(image.save).to eq(true)
    end
  end

  describe "association tests" do
    it { is_expected.to be_embedded_in(:section).as_inverse_of(:items) }
  end
end
