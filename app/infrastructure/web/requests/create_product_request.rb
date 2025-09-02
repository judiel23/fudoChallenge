module Infrastructure
  module Web
    module Requests
      class CreateProductRequest
        attr_reader :name, :price, :errors

        def initialize(params)
          @name = params['name']
          @price = params['price']
          @errors = []
        end

        def valid?
          @errors << 'name is required' unless @name && !@name.strip.empty?
          @errors << 'price must be a number' unless @price.is_a?(Numeric)
          @errors.empty?
        end
      end
    end
  end
end
