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
# Capybara.default_driver = :selenium_chrome
Capybara.default_driver = :selenium_firefox
# Capybara.default_driver = :rack_test