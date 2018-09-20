source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'bulma-rails', '~> 0.7.1'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'mongoid', '~> 6.4'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'haml-rails'
gem 'font-awesome-rails'
gem 'autoprefixer-rails', '~> 8.6', '>= 8.6.4'
gem 'devise'
gem 'jquery-rails'
gem 'cocoon'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'ragnarson-stylecheck'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'mongoid-rspec'
  gem 'database_cleaner'
end
