require 'sinatra'
require "sinatra/reloader"
require "sinatra/namespace"
require "sinatra/config_file"
require "sinatra/multi_route"

require 'haml'

module OAuthEmail
  class Web < Sinatra::Base
    register Sinatra::Reloader

    register Sinatra::Namespace
    register Sinatra::ConfigFile
    register Sinatra::MultiRoute

    set :public_folder, File.dirname(__FILE__) + '/assets'
    enable :sessions

    use Rack::MethodOverride

    get '/' do
      "hello world"
    end

    route :get, :post, '/authorize' do

    end
  end
end
