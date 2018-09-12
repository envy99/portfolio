require "rails_helper"

describe "Profile", type: :request do
  let!(:profile) { create(:profile) }
  let(:other_user) { create(:user) }
  let(:new_attributes) { attributes_for(:profile).stringify_keys! }
  let(:expected_attributes) { profile.attributes.merge(new_attributes) }

  describe "#edit" do
    context "with inappropriate user" do
      before do
        login_as(other_user, scope: :user)
        get "/profiles/#{profile.id}/edit"
      end

      it "should fail to show the profile editor" do
        expect(response).to redirect_to(profiles_path)
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("You do not own this profile!")
      end
    end

    context "with appropriate user" do
      before do
        login_as(profile.user, scope: :user)
        get "/profiles/#{profile.id}/edit"
      end

      it "should successfully show the profile editor" do
        expect(path).to eq(edit_profile_path)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "#update" do
    context "with inappropriate user" do
      before do
        login_as(other_user, scope: :user)
      end

      it "should fail to update the profile" do
        expect {
          put "/profiles/#{profile.id}", params: { profile: new_attributes }
        }.not_to change {
          profile.reload.attributes
        }

        expect(response).to redirect_to(profiles_path)
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("You do not own this profile!")
      end
    end

    context "with appropriate user" do
      before do
        login_as(profile.user, scope: :user)
      end

      it "should successfully update the profile" do
        expect {
          put "/profiles/#{profile.id}", params: { profile: new_attributes }
        }.to change {
          profile.reload.attributes
        }.from(profile.attributes).to(expected_attributes)

        expect(response).to redirect_to(profile_path(profile))
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq("Profile updated successfully!")
      end
    end
  end

  describe "#destroy" do
    context "with inappropriate user" do
      before do
        login_as(other_user, scope: :user)
      end

      it "should fail to delete the profile" do
        expect {
          delete "/profiles/#{profile.id}"
        }.to_not change {
          Profile.count
        }

        expect(response).to redirect_to(profiles_path)
        expect(response).to have_http_status(:redirect)
        expect(flash[:alert]).to eq("You do not own this profile!")
      end
    end

    context "with appropriate user" do
      before do
        login_as(profile.user, scope: :user)
      end

      it "should successfully delete the profile" do
        expect {
          delete "/profiles/#{profile.id}"
        }.to change {
          Profile.count
        }.by(-1)

        expect(response).to redirect_to(profiles_path)
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq("Profile deleted successfully!")
      end
    end
  end
end
