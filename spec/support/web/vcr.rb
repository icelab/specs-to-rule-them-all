require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = SPEC_ROOT.join("../tmp/vcr_casettes")
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.ignore_request do |request|
    # Ignore requests initiated from the browser (these are managed by Billy)
    request.headers.include?("Referer")
  end
end

module Test
  class VCRExampleHelpers < Module
    def initialize(example_name, enabled: true)
      define_method :use_cassette do |name, *args, &block|
        if enabled
          VCR.use_cassette("#{example_name}/#{name}", *args, &block)
        else
          block.call
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.around :each, vcr: -> vcr, metadata { !!vcr } do |example|
    enabled = !config.filter.rules[:full_integration]

    name = example
      .metadata[:full_description]
      .split(/\s+/, 2).join("/")
      .gsub(%r{[^\w\/]+}, "_")

    example.example.example_group_instance.send :extend, Test::VCRExampleHelpers.new(name, enabled: enabled)

    if enabled
      VCR.use_cassette(name) { example.call }
    else
      example.call
    end
  end
end
