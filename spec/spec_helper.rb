# Require the code we're testing
require 'oauth-email'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path('./spec/support/**/*.rb')].each {|f| require f}

ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding :ignore
  config.order = "random"
end
