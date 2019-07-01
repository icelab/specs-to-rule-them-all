ENV["RACK_ENV"] = "test"

require_relative "support/suite"

SPEC_ROOT = Pathname(__dir__).realpath
FIXTURES_PATH = SPEC_ROOT.join("fixtures").freeze

suite = Test::Suite.instance

suite.start_coverage
