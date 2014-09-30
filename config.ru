$:.unshift(File.expand_path(File.dirname(__FILE__)) + '/lib')

require 'oauth-email'

run OAuthEmail::Web
