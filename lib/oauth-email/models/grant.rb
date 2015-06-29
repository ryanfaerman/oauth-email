module OAuthEmail
  class Grant < ActiveRecord::Base
    self.inheritance_column = :_type_disabled

    enum type: [:authentication, :authorization, :access]

    belongs_to :application
    belongs_to :user

    validates :application, :user, presence: true

    after_initialize :set_default_type, if: :new_record?
    before_create :generate_token
    before_create :set_expiry, if: :expires?

    #
    # validate :single_authorization_grant_per_application

    scope :valid, -> { where('expires_at IS NULL OR expires_at > ?', Time.now)}

    alias_method :expires?, :authorization?

    def valid?
      expires_at.nil? || expires_at > Time.now
    end

    private

      def set_default_type
        self.type ||= :authentication
      end

      def generate_token(generator = Token::Authentication)
        loop do
          self.token = generator.call
          break unless self.class.exists?(token: self.token)
        end
      end

      def set_expiry
        self.expires_at = Time.now + 5.minutes if expires?
      end

      # def single_authorization_grant_per_application
      #   if self.class.authorizations.valid.present?
      #     errors.add(:grant_count_exceeded, 'too many active authorizations')
      #   end
      # end
  end
end
