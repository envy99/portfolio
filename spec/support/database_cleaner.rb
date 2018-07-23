RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  config.before(:each) do
    DatabaseCleaner.start unless self.class.metadata[:skip_db_cleaner]
  end

  config.after(:each) do
    DatabaseCleaner.clean unless self.class.metadata[:skip_db_cleaner]
  end
end
