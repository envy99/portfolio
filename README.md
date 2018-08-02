# Portfolio
![CircleCI](https://img.shields.io/circleci/project/envy99/portfolio/master.svg)

Portfolio is a web application, which enables users to create portfolios with ease.

## Some of the technologies used in Portfolio:
* Ruby
* Ruby on Rails
* MongoDB
* Haml
* Sass
* Bulma
* JavaScript
* Vue.js

## Prerequisites:
* Ruby
* MongoDB
* Chrome or Chromium web browser *(Chrome binary is needed for running certain automated tests)*

### How to determine prerequisites versions?

#### Ruby
Check `Gemfile` in order to determine which version of Ruby you will need to install.

#### MongoDB
**Portfolio** uses [mongoid gem](https://github.com/mongodb/mongoid) for communication with MongoDB.
That is why, the process of finding a suitable MongoDB version will take a few additional steps.
1. Check which version of mongoid we are using by inspecting the `Gemfile`
1. Visit [mongoid documentation](https://docs.mongodb.com/mongoid/master/) and choose from a dropdown mongoid version that you found in the `Gemfile`
1. Click on `Installation` and then proceed to `Compatibility` section
1. If everything was done correctly, you should be able to find a list of compatible MongoDB versions with the mongoid gem

## How to set up locally?
1. Clone the repository
	```
	$ git clone "https://github.com/envy99/portfolio.git"
	```
1. Enter **Portfolio** project directory
	```
	$ cd portfolio
	```
1. Setup **.env** file in root directory of the project by copying the example. Be sure to fill in the contents of this file after copying
	```
	$ cp .env.example .env
	```
1. Install all dependencies *(requires [bundler gem](https://github.com/bundler/bundler))*
	```
	$ bundle install
	```
1. Run the application
	```
	$ rails server
	```
1. Access **Portfolio** through the browser

	[Click here to open Portfolio](http://localhost:3000/)

## Contributing guidelines:

### Please read our guidelines before contributing to this project:
* [Front-end style guide](https://github.com/envy99/portfolio/blob/master/app/assets/stylesheets/README.md)
* [Ruby style guide](https://github.com/Ragnarson/style/blob/master/ruby/README.md)

### Tips for contributors:
* Portfolio uses [rubocop gem](https://github.com/rubocop-hq/rubocop) to check code styling. Make sure to run `rubocop` before committing your changes
* You can also run `bundle exec rake style` if you want [ragnarson-stylecheck gem](https://github.com/Ragnarson/ragnarson-stylecheck) to scan all of the files and potentially attempt automatic correction of the code styling issues
* Portfolio uses [rspec gem](https://github.com/rspec/rspec-rails) for automated tests. You should always remember to run `rspec` in order to check if all of the specs are passing
* There is no need to manually install webdriver, since [chromedriver-helper gem](https://github.com/flavorjones/chromedriver-helper) will take care of it for you

### Contributors:
A big thank you to [all the people](https://github.com/envy99/portfolio/graphs/contributors) who contributed to this project!
