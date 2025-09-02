require 'json'

module Infrastructure
  module Web
    module Responses
      class ApiResponse
        def self.success(data = {}, status = 200)
          [
            status,
            { "content-type" => "application/json" },
            [{ success: true, data: data }.to_json]
          ]
        end

        def self.error(status, message)
          [
            status,
            { "content-type" => "application/json" },
            [{ success: false, error: message }.to_json]
          ]
        end
      end
    end
  end
end
