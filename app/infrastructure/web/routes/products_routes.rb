require 'rack'
require 'json'
require_relative '../requests/create_product_request'
require_relative '../../../domain/products/create_product'
require_relative '../../../domain/products/list_products'
require_relative '../../jobs/job_queue'
require_relative '../responses/api_response'

module Infrastructure
  module Web
    module Routes
      class ProductsRoutes
        def initialize(product_repository)
          @repo = product_repository
          @list_use_case = Domain::Products::ListProducts.new(@repo)
          @create_use_case = Domain::Products::CreateProduct.new(@repo)
        end

        def call(env)
          req = Rack::Request.new(env)

          case req.request_method
          when 'GET'
            products = @list_use_case.call
            Responses::ApiResponse.success(products.map(&:to_h), 200)

          when 'POST'
            body = JSON.parse(req.body.read) rescue {}
            product_req = Requests::CreateProductRequest.new(body)

            unless product_req.valid?
              return Responses::ApiResponse.error(422, product_req.errors)
            end

            Infrastructure::Jobs::JobQueue.enqueue do
              sleep 5
              @create_use_case.call(product_req.name, product_req.price)
            end

            Responses::ApiResponse.success({ message: 'Product creation scheduled' }, 202)

          else
            Responses::ApiResponse.error(404, 'Not Found')
          end
        end
      end
    end
  end
end
