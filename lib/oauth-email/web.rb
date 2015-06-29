require 'sinatra'
require "sinatra/reloader"
require "sinatra/namespace"
require "sinatra/config_file"
require "sinatra/multi_route"

require "active_support/all"
require 'haml'

require 'rest-client'

module OAuthEmail
  module Errors
    class InvalidClientID < StandardError; end
    class RedirectMismatch < StandardError; end
    class UnauthorizedClient < StandardError; end
  end

  class Web < Sinatra::Base
    register Sinatra::Reloader

    register Sinatra::Namespace
    register Sinatra::ConfigFile
    register Sinatra::MultiRoute

    set :public_folder, File.dirname(__FILE__) + '/assets'
    enable :sessions
    set :sessions, :domain => 'localhost'

    use Rack::MethodOverride
    # use ActiveRecord::ConnectionAdapters::ConnectionManagement

    after do
      ActiveRecord::Base.connection.close
    end

    get '/' do
      "hello world"
    end

    get '/me' do
      content_type :json
      {
       name: "frank",
       email: 'foo@example.com',
       id: 123,
      }.to_json
    end

    error Errors::InvalidClientID do
      @error = env['sinatra.error']
      puts @error.inspect
      haml :error
    end

    namespace '/authenticate' do
      before do
        @user = User.new
      end

      get do
        haml :authenticate
      end

      post do
        @user.email = params['email']
        if @user.valid?
          @user.save
          session[:user_id] = @user.id
          redirect '/confirm'
        else
          haml :authenticate
        end
      end
    end

    namespace '/confirm' do
      get do
        "CONFIRM OR CONFORM"
      end
    end

    namespace '/oauth' do
      get '/authorize' do
        session['oauth.request'] = {
          state: params['state'],
          response_type: params['response_type'],
          grant_type: params['grant_type']
        }

        outcome = OAuthEmail::Command[:application].lookup(params)
        if outcome.success?
          session[:application_id] = outcome.result.id
          redirect '/authenticate'
        else
          @errors = outcome.errors
          haml :error
        end



        # payload = {
        #   token: Token::Authorization.call,
        #   expires_at: Time.now.to_i + 600,
        #   state: @state
        # }.select { |k,v| v.present? }

        # puts payload

        # redirect "#{@redirect_uri}?#{payload.to_query}"
      end



      post '/access_token' do
        content_type :json
        {
         access_token: "peepee",
         code: 'poopoo',
         token_type: "bearer",
         expires_in: false
        }.to_json
      end
    end


    namespace '/client' do
      before do
        @access_token  = params['access_token']
      end

      get do
        haml :client
      end

      get '/callback' do
        payload = {
          client_id: 'poop',
          client_secret: 'dookie',
          code: @access_token,
          grant_type: :authorization_code,
          redirect_uri: 'http://localhost:4567/client/callback'
        }.to_query

        RestClient.post 'http://localhost:4567/oauth/token', payload
      end
    end

  end
end
