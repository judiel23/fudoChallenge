module Domain
  module Products
    class ListProducts
      def initialize(repository)
        @repository = repository
      end

      def call
        @repository.all
      end
    end
  end
end
