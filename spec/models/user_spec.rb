require "rails_helper"

RSpec.describe User, type: :model do
  describe "association tests" do
    it { is_expected.to have_one(:profile) }
  end
end
