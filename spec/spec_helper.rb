require "webmock/rspec"
require 'vcr'

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.order = :random

end

WebMock.disable_net_connect!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
      :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:pnsdk, :uuid)]
  }
  c.configure_rspec_metadata!

end
