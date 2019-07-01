Dir[SPEC_ROOT.join("support/view/*.rb").to_s].each(&method(:require))

RSpec.configure do |config|
  config.define_derived_metadata(file_path: /views|parts/) do |metadata|
    metadata[:type] = :view
  end

  require "capybara/rspec"
  config.include Capybara::RSpecMatchers, type: :view

  config.include Test::ViewHelpers, type: :view
end
