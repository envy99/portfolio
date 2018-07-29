require "rails_helper"
require "support/vcr"

RSpec.feature "Using Linked in as authentication method", js: true do
  let(:user) { User.first }
  let(:linkedin_user) { create(:user, linkedin_id: "example") }
  let(:new_user) { create(:user) }

  it "for new user" do
    VCR.use_cassette "linkedin-valid" do
      visit oauth_linkedin_fetch_user_data_path
      fill_in "user[password]", with: "example"
      fill_in "user[password_confirmation]", with: "example"
      find("input[name='commit']").click

      expect(page).to have_content("Welcome! You have signed up using Linkedin.")
      expect(user.email).to eq("test1@example.com")
      expect(user.linkedin_id).to eq("example")
    end
  end

  it "for already created user not connected with linkedin" do
    VCR.use_cassette "linkedin-valid" do
      new_user
      visit oauth_linkedin_fetch_user_data_path
      fill_in "user[password]", with: "qwerty"
      find("input[name='commit']").click

      expect(page).to have_content("Welcome! You have signed up using Linkedin.")
      expect(user.linkedin_id).to eq("example")
    end
  end

  it "for user already connected to linkein" do
    VCR.use_cassette "linkedin-valid" do
      linkedin_user
      visit oauth_linkedin_fetch_user_data_path

      expect(page).to have_content("Signed in using Linkedin.")
    end
  end

  it "with not valid csrf token" do
    VCR.use_cassette "linkedin-valid" do
      visit oauth_linkedin_fetch_user_data_path(state: "Bad CSRF token")

      expect(page). to have_content("You are not authorized to access this page.")
    end
  end

  describe "but user canceled login on linkedin page" do
    it "with valid csrf token" do
      visit oauth_linkedin_fetch_user_data_path(error: "Login canceled")

      expect(page). to have_content("You have canceled login.")
    end

    it "with not valid csrf token" do
      visit oauth_linkedin_fetch_user_data_path(error: "Login canceled", state: "Bad CSRF token")

      expect(page). to have_content("You are not authorized to access this page.")
    end
  end
end
