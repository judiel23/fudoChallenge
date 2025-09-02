require 'rack'
require 'json'
require_relative '../controllers/products_controller'
require_relative '../responses/api_response'

module Infrastructure
  module Web
    module Routes
      class ProductsRoutes
        def initialize(repo)
          @controller = Controllers::ProductsController.new(repo)
        end

        def call(env)
          req = Rack::Request.new(env)
          path_parts = req.path_info.split('/').reject(&:empty?)

          case [req.request_method, path_parts.length]
          when ['GET', 1] # GET /products
            return @controller.index
          when ['POST', 1] # POST /products
            body = JSON.parse(req.body.read) rescue {}
            return @controller.create(body)
          when ['GET', 2] # GET /products/:id
            id = path_parts[1].to_i
            return @controller.show(id)
          else
            return Responses::ApiResponse.error(404, 'Not Found')
          end
        end
      end
    end
  end
end
