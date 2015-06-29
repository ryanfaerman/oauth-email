require 'bundler/setup'
require 'pry'
require 'active_record'
require 'sinatra/activerecord'

require 'valid_email/email_validator'

require 'mutations'

ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     'localhost',
  username: 'root',
  password: '',
  database: 'oauth-email_development'
)

I18n.enforce_available_locales = false

module OAuthEmail

  def self.load!
    path = File.expand_path('./**/*.rb', File.dirname(__FILE__))
    Dir[path].each { |lib| require(lib) }
  end

  def self.reload!
    Object.send(:remove_const, :OAuthEmail)
    path = File.expand_path("../", __FILE__)
    Dir.glob("#{path}/**/*.rb") { |f| load f }
  end

  def self.❨╯°□°❩╯︵┻━┻
    puts "Calm down, bro"
  end
end

OAuthEmail.load!
