require "rails_helper"

RSpec.feature "Deleting a profile" do
  let!(:profile) { create(:profile) }
  let(:other_user) { create(:user) }

  describe "a signed in user" do
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

    scenario "can't delete someone else's profile" do
      login_as(other_user, scope: :user)
      visit profiles_path
      click_link profile.name

      expect(page).not_to have_link("Delete", href: profile_path(profile))
      expect(current_path).to eq(profile_path(profile))
    end
  end

  describe "an anonymous user" do
    scenario "can't delete someone's profile" do
      visit profiles_path
      click_link profile.name

      expect(page).not_to have_link("Delete", href: profile_path(profile))
      expect(current_path).to eq(profile_path(profile))
    end
  end
end
