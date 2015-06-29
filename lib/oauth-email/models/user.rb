module OAuthEmail
  class User < ActiveRecord::Base
    has_many :grants
    has_many :applications, through: :grants

    validates :email, presence: true
    validate :email_has_strudel_and_sides_and_tld

    before_create :generate_token

    private

      def email_has_strudel_and_sides_and_tld
        has_strudel = '@'.in?(email)
        has_sides = email.split('@').reject(&:empty?).length == 2
        has_tld = email.split('@').last.split('.').reject(&:empty?).length >= 2

        if !has_strudel || !has_sides || !has_tld
          errors.add(:email, 'invalid address')
        end
      end

      def generate_token(generator = Token::User)
        loop do
          self.token = generator.call
          break unless self.class.exists?(token: self.token)
        end
      end
  end
end
