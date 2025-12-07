ENV['RACK_ENV'] = 'test'

# Code coverage with SimpleCov
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/features/'
  coverage_dir 'coverage'
end

require_relative '../app'
require 'capybara/rspec'
require 'rack/test'

# Configure Capybara
Capybara.app = TaskApp

RSpec.configure do |config|
  config.include Capybara::DSL

  # Reset tasks before each test
  config.before(:each) do
    TaskApp.settings.tasks.clear
  end

  # Disable monkey patching
  config.disable_monkey_patching!

  # Use expect syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Use color in output
  config.color = true

  # Output format
  config.formatter = :documentation
end
