require "rails_helper"

RSpec.feature "Editing a profile", js: true, skip_db_cleaner: true do
  before(:all) { @profile = create(:profile) }

  describe "a user edits his profile" do
    before { login_as(@profile.user, scope: :user) }

    scenario "by changing the profile name" do
      visit profiles_path
      click_link @profile.name
      click_link "Edit"

      fill_in "Name", with: "New profile name"

      click_button "Update profile"

      expect(page).to have_content("Profile updated successfully!")
      expect(current_path).to eq(profile_path(@profile))
      within("#profile") { expect(page).to have_content("New profile name") }
    end

    scenario "by adding a new section to profile" do
      visit edit_profile_path(@profile)

      within ".js-sections" do
        click_link "Add new section"
        fill_in "Name", with: "New section name"
      end

      click_button "Update profile"

      within("#profile") { expect(page).to have_content("New section name") }
    end

    scenario "by adding new items to section" do
      visit edit_profile_path(@profile)

      within ".js-items" do
        click_link "Add new item"
        within all(".box")[0] do
          select "text", from: "Type"
          fill_in "Content", with: "New item body"
        end

        click_link "Add new item"
        within all(".box")[1] do
          select "image", from: "Type"
          fill_in "Content", with: "https://example.com/image.png"
        end
      end

      click_button "Update profile"

      within("#profile") do
        expect(page).to have_content("New item body")
        expect(page).to have_css("img[src='https://example.com/image.png']")
      end
    end
  end
end
