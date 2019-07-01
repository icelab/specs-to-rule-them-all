Snowpack.application.start :persistence

Dir[SPEC_ROOT.join("support/db/*.rb").to_s].each(&method(:require))

require "database_cleaner"
DatabaseCleaner[:sequel, connection: Test::DatabaseHelpers.db].strategy = :truncation

RSpec.configure do |config|
  config.include Test::DatabaseHelpers

  # TODO: build these dynamically from Snowpack.appliciation.slices
  # config.define_derived_metadata(file_path: /admin/) do |metadata|
  #   metadata[:factory] = :admin
  # end

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.around :example do |example|
    if suite.clean_db?(example) || example.metadata[:db]
      DatabaseCleaner.cleaning do
        example.run
      end
    else
      example.run
    end
  end

  # TODO: build these dynamically from Snowpack.application.slices
  # config.include(Test::FactoryHelper.new(:admin), factory: :admin)
  # config.include(Test::FactoryHelper.new(:main), factory: :main)
  # config.include(Test::FactoryHelper.new, factory: nil)
end
