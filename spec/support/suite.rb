require "snowpack/test/suite"

module Test
  class Suite < Snowpack::Test::Suite
    configure do |config|
      require_relative "helpers"
      config.include Test::Helpers

      require_relative "time_helpers"
      config.include Test::TimeHelpers
    end
  end
end
