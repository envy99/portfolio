require "rails_helper"

RSpec.feature "Showing a single profile" do
  let!(:profile) { create(:profile) }
  let(:other_user) { create(:user) }

  describe "to a signed in user" do
    scenario "who owns the profile" do
      login_as(profile.user, scope: :user)
      visit profiles_path
      click_link profile.name

      expect(page).to have_content(profile.name)
      within ".message" do
        expect(page).to have_link("Edit", href: edit_profile_path(profile))
        expect(page).to have_link("Delete", href: profile_path(profile))
      end
      expect(current_path).to eq(profile_path(profile))
    end

    scenario "who doesn't own the profile" do
      login_as(other_user, scope: :user)
      visit profiles_path
      click_link profile.name

      expect(page).to have_content(profile.name)
      expect(page).not_to have_link("Edit", href: edit_profile_path(profile))
      expect(page).not_to have_link("Delete", href: profile_path(profile))
      expect(current_path).to eq(profile_path(profile))
    end
  end

  scenario "to an anonymous user" do
    visit profiles_path
    click_link profile.name

    expect(page).to have_content(profile.name)
    expect(page).not_to have_link("Edit", href: edit_profile_path(profile))
    expect(page).not_to have_link("Delete", href: profile_path(profile))
    expect(current_path).to eq(profile_path(profile))
  end
end
