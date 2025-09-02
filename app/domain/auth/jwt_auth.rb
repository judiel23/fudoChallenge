require 'jwt'

module Domain
  module Auth
    class JwtAuth
      SECRET = 'super_secret_key'

      def self.encode(payload)
        JWT.encode(payload, SECRET, 'HS256')
      end

      def self.decode(token)
        JWT.decode(token, SECRET, true, { algorithm: 'HS256' }).first
      end
    end
  end
end
