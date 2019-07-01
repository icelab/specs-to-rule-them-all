Snowpack.application.start :que

RSpec.configure do |config|
  config.before :suite do
    # Run Que jobs inline during tests
    Snowpack.application[:que].run_synchronously = true
  end
end
