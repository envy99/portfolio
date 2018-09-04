require "rails_helper"

RSpec.feature "Deleting a profile" do
  let!(:profile) { create(:profile) }

  describe "a user" do
    scenario "deletes his profile" do
      login_as(profile.user, scope: :user)
      visit profiles_path
      click_link profile.name
      within ".message" do
        click_link "Delete"
      end

      expect(page).to have_content("Profile deleted successfully!")
      expect(current_path).to eq(profiles_path)
    end
  end
end
