require "rails_helper"

RSpec.describe Item, type: :model do
  describe "association tests" do
    it { is_expected.to be_embedded_in(:section).as_inverse_of(:items) }
  end
end
