require "rails_helper"
RSpec.describe Oauth::Linkedin::FetchUrl do
  let(:api_key) { ENV["linkedin_api_key"] }
  let(:redirect_url) { ENV["host"] + "/oauth/linkedin/fetch_user_data" }
  let(:request_url) { "https://www.linkedin.com/oauth/v2/authorization" }
  let(:csrf_token) { "test" }
  subject { described_class }
  it "generates valid link" do
    expect(subject.call(csrf_token: csrf_token)).to(
      eq "#{request_url}?response_type=code&client_id=#{api_key}&redirect_uri=#{redirect_url}&state=#{csrf_token}"
    )
  end
end
