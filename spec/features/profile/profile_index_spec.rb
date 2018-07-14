require "rails_helper"

RSpec.feature "Showing a list of profiles" do
  let!(:profile1) { create(:profile) }
  let!(:profile2) { create(:profile) }

  describe "a visitor" do
    scenario "sees the list of profiles" do
      visit profiles_path

      expect(page).to have_link(profile1.name)
      expect(page).to have_link(profile2.name)
      expect(current_path).to eq(profiles_path)
    end

    scenario "sees information about no profiles to display" do
      Profile.delete_all

      visit profiles_path

      expect(page).to have_content("There are no profiles created yet.")
      expect(current_path).to eq(profiles_path)
    end
  end
end
