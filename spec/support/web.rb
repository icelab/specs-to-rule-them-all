require_relative "db"

require "capybara/cuprite"
require "capybara/rspec"
require "capybara-screenshot/rspec"
require "rack/test"
require "rspec/retry"

Dir[SPEC_ROOT.join("support/integration/*.rb").to_s].each(&method(:require))
Dir[SPEC_ROOT.join("support/web/*.rb").to_s].each(&method(:require))

Snowpack.application.boot!

suite = Test::Suite.instance

# Stop ES indexer in specs
# Admin::Container[:indexer].stop

Capybara.app = Test::WebHelpers.web_app
Capybara.server = :puma, {Silent: true}
Capybara.server_port = suite.capybara_server_port
Capybara.test_id = "data-test"
Capybara.default_max_wait_time = 5
Capybara.save_path = suite.tmp_dir.join("capybara-screenshot").to_s
Capybara.javascript_driver = :cuprite

Capybara.register_driver :cuprite do |app|
  browser_options =
    if RSpec.configuration.filter.rules[:full_integration]
      {}
    else
      {
        "ignore-certificate-errors" => nil,
        "proxy-server" => "#{Billy.proxy.host}:#{Billy.proxy.port}",
        "proxy-bypass-list" => "127.0.0.1;localhost",
      }
    end

  Capybara::Cuprite::Driver.new(
    app,
    # logger: $stderr,
    window_size: [1600, 1600],
    browser_options: browser_options,
  )
end

Capybara::Screenshot.register_driver(:cuprite, &Capybara::Screenshot.registered_drivers[:default])
Capybara::Screenshot.prune_strategy = {keep: 10}

RSpec.configure do |config|
  config.define_derived_metadata(file_path: /(requests|features)/) do |metadata|
    metadata[:integration] = true
  end

  config.define_derived_metadata(file_path: /requests/) do |metadata|
    metadata[:type] = :request
  end

  config.include Rack::Test::Methods, type: :request
  config.include Rack::Test::Methods, Capybara::DSL, type: :feature
  config.include Test::WebHelpers

  # config.before :suite do
  #   Test::WebHelpers.web_app.freeze
  # end

  # Is this needed?
  config.append_after :each do
    Capybara.reset_sessions!
  end

  # Retry setup
  config.verbose_retry = true
  config.display_try_failure_messages = true

  config.around :each, :js do |example|
    example.run_with_retry retry: 3
  end

  config.retry_callback = -> example {
    Capybara.reset_sessions! if example.metadata[:js]
    DatabaseCleaner.clean
  }
end
