require "rails_helper"

RSpec.feature "Editing a profile" do
  let!(:profile) { create(:profile) }
  let(:other_user) { create(:user) }

  describe "a signed in user" do
    scenario "edits his profile" do
      login_as(profile.user, scope: :user)
      visit profiles_path
      click_link profile.name
      within ".message" do
        click_link "Edit"
      end
      fill_in "Name", with: "Updated name"
      click_button "Update profile"

      expect(page).to have_content("Profile updated successfully!")
      expect(page).to have_content("Updated name")
      expect(current_path).to eq(profile_path(profile))
    end

    scenario "can't edit someone else's profile" do
      login_as(other_user, scope: :user)
      visit profiles_path
      click_link profile.name

      expect(page).not_to have_link("Edit", href: edit_profile_path(profile))
      expect(current_path).to eq(profile_path(profile))
    end
  end

  describe "an anonymous user" do
    scenario "can't edit someone's profile" do
      visit profiles_path
      click_link profile.name

      expect(page).not_to have_link("Edit", href: edit_profile_path(profile))
      expect(current_path).to eq(profile_path(profile))
    end
  end
end
