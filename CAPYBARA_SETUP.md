# Capybara Installation and Setup

## Prerequisites

- Ruby (version 2.6 or higher recommended)
- Bundler gem installed

## Installation

1. **Add Capybara to your Gemfile:**

```ruby
group :test do
  gem 'capybara'
  gem 'selenium-webdriver' # For JavaScript testing
end
```

2. **Install dependencies:**

```bash
bundle install
```

## Basic Setup

### For RSpec

1. **Add to your `spec/spec_helper.rb` or `spec/rails_helper.rb`:**

```ruby
require 'capybara/rspec'

# If testing a Rack app (non-Rails)
Capybara.app = YourRackApp

# Configure default driver (optional)
Capybara.default_driver = :selenium # or :rack_test for non-JS tests
```

### For Cucumber

1. **Add to `features/support/env.rb`:**

```ruby
require 'capybara/cucumber'

Capybara.app = YourRackApp
```

### For Minitest

1. **Add to your test helper:**

```ruby
require 'capybara/minitest'

class CapybaraTestCase < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions
end
```

## Quick Start

### Example Test (RSpec)

```ruby
feature 'User visits homepage' do
  scenario 'they see a welcome message' do
    visit '/'
    expect(page).to have_content('Welcome')
  end
end
```

### Example Test (Minitest)

```ruby
class HomePageTest < CapybaraTestCase
  def test_welcome_message
    visit '/'
    assert_text 'Welcome'
  end
end
```

## Running Tests

```bash
# For RSpec
bundle exec rspec

# For Cucumber
bundle exec cucumber

# For Minitest
bundle exec ruby -Itest test/your_test.rb
```

## Common Drivers

- **rack_test** (default): Fast, but no JavaScript support
- **selenium**: Full browser automation, supports JavaScript
- **selenium_chrome_headless**: Headless Chrome for CI/CD

## Additional Resources

- Official Documentation: https://github.com/teamcapybara/capybara
- API Documentation: https://rubydoc.info/github/teamcapybara/capybara/master
