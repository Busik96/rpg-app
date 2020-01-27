# frozen_string_literal: true

module Users
  class TokenGenerator
    def call(user)
      loop do
        token = SecureRandom.uuid
        break user.update!(api_key: token) unless User.exists?(api_key: token)
      end

      user.api_key
    end
  end
end
