require_relative 'product'

module Domain
  module Products
    class CreateProduct
      def initialize(repository)
        @repository = repository
      end

      def call(name, price)
        product = Product.new(id: @repository.next_id, name: name, price: price)
        @repository.add(product)
        product
      end
    end
  end
end
