require "rails_helper"

RSpec.describe Section, type: :model do
  describe "validation tests" do
    context "for name" do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe "association tests" do
    it { is_expected.to be_embedded_in(:profile).as_inverse_of(:sections) }
    it { is_expected.to embed_many(:items) }
  end
end
