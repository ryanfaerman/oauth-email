require 'securerandom'

module OAuthEmail
  module Token
    class Base
      def self.call(size)
        SecureRandom.hex(size / 8).to_i(16).to_s(36)
      end
    end

    class ClientID < Base
      def self.call(size = 100)
        super
      end
    end

    class ClientSecret < Base
      def self.call(size = 200)
        super
      end
    end

    class User < Base
      def self.call(size = 100)
        super
      end
    end
  end
end
