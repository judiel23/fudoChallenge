require 'json'

module Infrastructure
  module Web
    module Middlewares
      class ErrorHandler
        def initialize(app)
          @app = app
        end

        def call(env)
          @app.call(env)
        rescue StandardError => e
          [
            500,
            { 'content-type' => 'application/json' },
            [{ error: e.message }.to_json]
          ]
        end
      end
    end
  end
end