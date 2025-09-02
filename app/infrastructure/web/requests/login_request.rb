module Infrastructure
  module Web
    module Requests
      class LoginRequest
        attr_reader :email, :password, :errors

        def initialize(params)
          params = params.transform_keys(&:to_sym) if params.is_a?(Hash)
          @errors = []
          @email = params[:email]
          @password = params[:password]
          validate
        end

        def valid?
          @errors.empty?
        end

        private

        def validate
          @errors << "email is required" if email.nil? || email.strip.empty?
          @errors << "password is required" if password.nil? || password.strip.empty?
        end
      end
    end
  end
end
