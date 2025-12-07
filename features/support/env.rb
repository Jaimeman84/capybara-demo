ENV['RACK_ENV'] = 'test'

require_relative '../../app'
require 'capybara/cucumber'
require 'rack/test'

# Configure Capybara to test our Sinatra app
Capybara.app = TaskApp

# Reset tasks before each scenario
Before do
  TaskApp.settings.tasks.clear
end

# ========== ADD VISIBLE BROWSER DRIVERS ==========

# Chrome (visible)
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Firefox (visible)
Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

# Set default driver for visible execution (optional)
# Use environment variable for CI/CD, otherwise use visible browser
if ENV['CI'] || ENV['CAPYBARA_DRIVER'] == 'rack_test'
  # Headless for CI
  Capybara.default_driver = :rack_test
else
  # Visible browser for local development
  # Capybara.default_driver = :selenium_chrome
  Capybara.default_driver = :selenium_firefox
end