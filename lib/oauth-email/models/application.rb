module OAuthEmail
  class Application < ActiveRecord::Base
    has_many :grants
    has_many :users, through: :grants

    validates :name, presence: true, uniqueness: true
    validates :redirect_uri, presence: true
    validate :check_format_of_redirect_uri

    before_create :generate_client_id, :generate_client_secret

    private

      def check_format_of_redirect_uri
        uri = URI.parse(redirect_uri)
        errors.add(:redirect_uri, 'must be an absolute URI') unless uri.absolute?
      rescue
        errors.add(:redirect_uri, 'must be a URI')
      end

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
