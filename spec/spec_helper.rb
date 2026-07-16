# frozen_string_literal: true

require 'jekyll-external-link-accessibility'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end

# The gem only touches page.output, page.output= and page.site.config, so a
# couple of Structs are enough to stand in for a real Jekyll page.
def fake_page(html, config = {})
  site = Struct.new(:config).new(config)
  Struct.new(:output, :site).new(html, site)
end
