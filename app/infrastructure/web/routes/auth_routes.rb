require 'rack'
require 'json'
require_relative '../requests/login_request'
require_relative '../../../domain/auth/jwt_auth'
require_relative '../responses/api_response'

module Infrastructure
  module Web
    module Routes
      class AuthRoutes
        def initialize(users_repo)
          @users_repo = users_repo
        end

        def call(env)
          req = Rack::Request.new(env)

          unless req.post?
            return Responses::ApiResponse.error(405, 'Method not allowed')
          end

          body = JSON.parse(req.body.read) rescue {}
          login_req = Infrastructure::Web::Requests::LoginRequest.new(body)

          unless login_req.valid?
            return Responses::ApiResponse.error(422, login_req.errors)
          end

          user = @users_repo.find_by_email(login_req.email)
          unless user && user[:password] == login_req.password
            return Responses::ApiResponse.error(401, 'Invalid credentials')
          end

          token = Domain::Auth::JwtAuth.encode({ user_id: login_req.email })

          Responses::ApiResponse.success({ token: token })
        end

        private

        def extract_token(req)
          req.fetch_header('HTTP_AUTHORIZATION', nil)&.split(' ')&.last
        end
      end
    end
  end
end
