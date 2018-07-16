require "rails_helper"

RSpec.feature "Creating a profile" do
  describe "after user registration" do
    scenario "create his profile" do
      visit new_user_registration_path
      fill_in "user_email", with: "test@example.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      find("button[name='button']").click
      within("#nav_menu") do
        click_link("Profiles")
      end
      profile_container = find("div", class: "box")
      expect(profile_container).to have_content("Test")
    end
  end
end
