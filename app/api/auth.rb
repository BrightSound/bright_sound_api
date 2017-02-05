module BrightSound
  class Base < Grape::API
    module Auth
      attr_reader :current_user

      def authenticate!
        unless user_id_in_token?
          unauthenticated
        end
        @current_user = User.with_pk!(auth_token[:user_id])
      rescue JWT::DecodeError, Sequel::NoMatchingRow
        unauthenticated
      end

    private

      def user_id_in_token?
        http_token && auth_token && auth_token[:user_id].to_i
      end

      def unauthenticated
        # TODO: translate
        error!('Authentication error', 401)
      end

      def http_token
        @http_token ||=
          if headers['Authorization'].present?
            headers['Authorization'].split(' ').last
          end
      end

      def auth_token
        @auth_token ||= JsonWebToken.decode(http_token)
      end
    end
  end
end
