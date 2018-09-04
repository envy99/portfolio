require "rails_helper"

describe "profiles/index.html.haml" do
  context "when there is at least one profile" do
    let!(:profile1) { create(:profile) }
    let!(:profile2) { create(:profile) }

    it "shows a list of profiles" do
      assign(:profiles, Profile.all)
      render template: "profiles/index.html.haml"

      expect(rendered).to have_link(profile1.name)
      expect(rendered).to have_link(profile2.name)
    end
  end

  context "when there are no profiles" do
    it "shows an information about no profiles to list" do
      assign(:profiles, Profile.all)
      render template: "profiles/index.html.haml"

      expect(rendered).to have_content("There are no profiles created yet.")
    end
  end
end
