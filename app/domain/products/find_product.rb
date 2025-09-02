module Domain
  module Products
    class FindProduct
      def initialize(repo)
        @repo = repo
      end

      def call(id)
        @repo.find_by_id(id)
      end
    end
  end
end