module OAuthEmail
  class Application < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    validates :redirect_uri, presence: true, format: { with: /\Ahttps?:\/\//, message: 'only allows valid URIs'}

    before_create :generate_client_id, :generate_client_secret

    private

      def generate_client_id(generator = Token::ClientID)
        loop do
          self.client_id = generator.call
          break unless self.class.exists?(client_id: self.client_id)
        end
      end

      def generate_client_secret(generator = Token::ClientSecret)
        self.client_secret = generator.call
      end
  end
end
