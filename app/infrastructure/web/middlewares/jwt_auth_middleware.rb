require_relative '../../../domain/auth/jwt_auth'
require_relative '../responses/api_response'

module Infrastructure
  module Web
    module Middleware
      class JwtAuthMiddleware
        def initialize(app)
          @app = app
        end

        def call(env)
          req = Rack::Request.new(env)

          # Solo proteger rutas específicas (por ejemplo, /products)
          if protected_path?(req.path)
            header = req.get_header('HTTP_AUTHORIZATION')
            unless header&.start_with?('Bearer ')
              return unauthorized_response
            end

            token = header.split(' ').last
            payload = decode_token(token)
            unless payload
              return unauthorized_response
            end

            env['current_user_id'] = payload['user_id']
          end

          @app.call(env)
        end

        private

        def protected_path?(path)
          path.start_with?('/products')
        end

        def decode_token(token)
          Domain::Auth::JwtAuth.decode(token)
        rescue StandardError
          nil
        end

        def unauthorized_response
          Responses::ApiResponse.error(401, 'Unauthorized')
        end
      end
    end
  end
end
