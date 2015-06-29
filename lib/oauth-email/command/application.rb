module OAuthEmail
  module Command
    module Application
      class Lookup < ::Mutations::Command
        required do
          string :client_id
          string :redirect_uri
        end

        def validate
          unless ::OAuthEmail::Application.exists?(client_id: client_id)
            add_error(:client_id, :invalid, 'Client ID is invalid')
          end
        end

        def execute
          application = ::OAuthEmail::Application.find_by_client_id(client_id)
          if redirect_uri != application.redirect_uri
            add_error(:redirect_uri, :mismatch, 'Request URI does not match')
          end

          application
        end
      end
    end
  end
end
