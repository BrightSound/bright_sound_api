require 'grape'
module BrightSound
  class API < Grape::API
    version 'v1', using: :header, vendor: 'bright_sound'
    format :json
    prefix :api

    helpers do
      def authenticate!
        unless user_id_in_token?
          unauthenticated
          return
        end
        @current_user = User.with_pk!(auth_token[:user_id])
        raise @current_user.inspect
      rescue JWT::DecodeError
        unauthenticated
      end

      def http_token
        @http_token ||= if headers['Authorization'].present?
          headers['Authorization'].split(' ').last
        end
      end

      def auth_token
        @auth_token ||= JsonWebToken.decode(http_token)
      end

      def user_id_in_token?
        http_token && auth_token && auth_token[:user_id].to_i
      end

      def unauthenticated
        Rack::Response.new(
          [{ status: 401, status_code: 'unauthenticated', error: 'Not Authenticated' }.to_json],
          401,
          { 'Content-Type' => 'application/json' }
        )
      end
    end

    resource :tests do
      # curl -X GET localhost:9292/api/tests/response
      desc 'Test Route'
      get :response do
        authenticate!
        { this_is_a_test: 'hello everybody'}
      end
    end
  end
end
