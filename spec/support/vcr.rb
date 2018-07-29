VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :webmock
  c.ignore_localhost = true
  c.filter_sensitive_data("<CLIENT_SECRET>") { ENV["linkedin_secret_api_key"] }
  c.filter_sensitive_data("<CLIENT_ID>") { ENV["linkedin_api_key"] }
end
