ENV['RACK_ENV'] ||= 'test'

require 'rack/test'
require 'factory_girl'
require 'faker'
require 'database_cleaner'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
    FactoryGirl.define do
      to_create { |instance| instance.save }
    end
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
