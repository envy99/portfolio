require "rails_helper"

describe "profiles/show.html.haml" do
  let(:other_user) { create(:user) }
  let(:profile) { create(:profile, :filled_with_content) }

  before do
    assign(:profile, profile)
  end

  it "shows a single profile" do
    allow(view).to receive(:current_user).and_return(profile.user)
    render template: "profiles/show.html.haml"

    expect(rendered).to have_content(profile.name)
    profile.sections.each do |section|
      expect(rendered).to have_content(section.name)
      section.items.each do |item|
        case item.type
        when :text
          expect(rendered).to have_content(item.content)
        when :image
          expect(rendered).to have_css("img[src='#{item.content}']")
        end
      end
    end
  end

  describe "to a signed in user" do
    context "who owns the profile" do
      it "shows a management panel" do
        allow(view).to receive(:current_user).and_return(profile.user)
        render template: "profiles/show.html.haml"

        expect(rendered).to have_link("Edit", href: edit_profile_path(profile))
        expect(rendered).to have_link("Delete", href: profile_path(profile))
      end
    end

    context "who doesn't own the profile" do
      it "doesn't show a management panel" do
        allow(view).to receive(:current_user).and_return(other_user)
        render template: "profiles/show.html.haml"

        expect(rendered).not_to have_link("Edit", href: edit_profile_path(profile))
        expect(rendered).not_to have_link("Delete", href: profile_path(profile))
      end
    end
  end
end
