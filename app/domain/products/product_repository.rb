module Domain
  module Products
    class ProductRepository
      @@instance = new

      def self.instance
        @@instance
      end

      attr_reader :products, :next_id

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

      def find_by_id(id)
        @products.find { |p| p.id == id }
      end
    end
  end
end
