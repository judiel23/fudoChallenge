require_relative 'routes/auth_routes'
require_relative 'routes/products_routes'
require_relative '../../mock/users_repository'
require_relative '../../domain/products/product_repository'

module Infrastructure
  module Web
    class App
      def initialize(users_repo:, products_repo:)
        @users_repo = users_repo
        @products_repo = products_repo

        @routes = {
          '/auth/login' => Routes::AuthRoutes.new(@users_repo),
          '/products'   => Routes::ProductsRoutes.new(@products_repo)
        }
      end

      # Rack entry point
      def call(env)
        req = Rack::Request.new(env)
        path = req.path_info

        route = @routes.find { |base_path, _handler| path.start_with?(base_path) }
        if route
          _, handler = route
          handler.call(env)
        else
          [404, { 'content-type' => 'application/json' }, [{ error: 'Not Found' }.to_json]]
        end
      end
    end
  end
end
