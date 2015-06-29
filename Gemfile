source "https://rubygems.org"
ruby '2.1.1'

gem 'rake'


gem 'sinatra'
gem 'sinatra-contrib'
gem "sinatra-activerecord"

gem 'haml'

# gem 'oauth2-provider'
gem 'activerecord'
gem 'mysql2'
gem 'activesupport'

gem 'rest-client'

gem 'mutations'
gem 'valid_email', :require => 'valid_email/email_validator'

group :development do
  gem 'thin'
end

group :test do
  gem 'pry'
  gem 'rspec'

  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-bundler'

  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'terminal-notifier-guard'
end

group :production do
  gem 'puma'
end
