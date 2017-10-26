module BrightSound
  class API < Grape::API
    prefix 'api'
    format :json

    helpers do
      def authenticate!
        error!('Unauthorized', 401) unless current_user
      end

      def login
        warden.authenticate!(:password)
      end

      def warden
        @warden ||= env['warden']
      end

      def current_user
        @current_user ||= warden.user
      end
    end
    mount ::BrightSound::Authentication
    mount ::BrightSound::Test
  end
end
