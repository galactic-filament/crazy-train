ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "simplecov"
require "simplecov-lcov"
require "simplecov-console"

SimpleCov.start "rails" do
  if ENV["CI"]

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
    end

    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::LcovFormatter,
      SimpleCov::Formatter::Console
    ])
  else
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Console
    ])
  end
end
Rails.application.eager_load!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
