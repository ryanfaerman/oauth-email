require 'bundler/setup'
require 'sinatra/activerecord/rake'

task :environment do
  $:.unshift(File.expand_path(File.dirname(__FILE__)) + '/lib')

  require 'oauth-email'
end

task :console => :environment do
  require 'pry'

  Pry::Commands.block_command "reload!", "reload da code" do
    OAuthEmail.reload!
  end

  ARGV.clear
  Pry.start
end

task :web => :environment do
  OAuthEmail::Web.run!
end


namespace :db do
  task :load_config do
    ActiveRecord::Base.establish_connection(
      adapter:  'mysql2',
      host:     'localhost',
      username: 'root',
      password: '',
      database: 'oauth-email_development'
    )
  end
end

task :default => :web
