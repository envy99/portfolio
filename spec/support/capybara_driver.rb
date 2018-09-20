Capybara.javascript_driver = :selenium_chrome_headless
Capybara.server_port = "1234"
Capybara.server_host = "localhost"
Capybara.app_host = "http://localhost:#{Capybara.server_port}"
# Use :selenium_chrome if you want to see how the test is being performed
# or :selenium_chrome_headless if the test should run in the background.
