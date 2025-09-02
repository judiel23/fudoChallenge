require_relative '../responses/api_response'
require_relative '../requests/create_product_request'
require_relative '../../../domain/products/create_product'
require_relative '../../../domain/products/list_products'
require_relative '../../../domain/products/find_product'
require_relative '../../jobs/job_queue'

module Infrastructure
  module Web
    module Controllers
      class ProductsController
        def initialize(repo)
          @repo = repo
          @list_use_case = Domain::Products::ListProducts.new(@repo)
          @create_use_case = Domain::Products::CreateProduct.new(@repo)
          @find_use_case = Domain::Products::FindProduct.new(@repo)
        end

        def index
          products = @list_use_case.call
          Responses::ApiResponse.success(products.map(&:to_h))
        end

        def show(id)
          product = @find_use_case.call(id)
          return Responses::ApiResponse.error(404, 'Product not found') unless product

          Responses::ApiResponse.success(product.to_h)
        end

        def create(body)
          product_req = Infrastructure::Web::Requests::CreateProductRequest.new(body)
          unless product_req.valid?
            return Responses::ApiResponse.error(422, product_req.errors)
          end

          new_id = @repo.next_id

          Infrastructure::Jobs::JobQueue.enqueue do
            sleep 5
            @create_use_case.call(new_id, product_req.name, product_req.price)
          end

          Responses::ApiResponse.success({ message: 'Product creation scheduled', id: new_id }, 202)
        end
      end
    end
  end
end
