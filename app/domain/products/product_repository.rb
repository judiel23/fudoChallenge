module Domain
  module Products
    class ProductRepository
      def initialize
        @products = []
        @next_id = 1
      end

      def all
        @products
      end

      def add(product)
        @products << product
      end

      def next_id
        id = @next_id
        @next_id += 1
        id
      end
    end
  end
end
