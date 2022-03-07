ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "simplecov"

SimpleCov.start "rails" do
  if ENV["CI"]
    require "simplecov-lcov"
    require "coveralls"

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = "coverage/lcov.info"
    end

    formatter SimpleCov::Formatter::LcovFormatter
    Coveralls.wear!
  else
    formatter SimpleCov::Formatter::HTMLFormatter
  end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
