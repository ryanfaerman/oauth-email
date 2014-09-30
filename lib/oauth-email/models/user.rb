module OAuthEmail
  class User < ActiveRecord::Base
    validates :email, presence: true

    before_create :generate_token

    private

      def generate_token(generator = Token::User)
        self.token = generator.call while self.class.exists?(token: self.token)
      end
  end
end
