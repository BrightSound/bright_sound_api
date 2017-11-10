module BrightSound
  module Endpoints
    class Base < Grape::API
      module Helpers
        module Authentication
          def authenticate!
            error!('Unauthorized', 401) unless current_user
          end

          def login
            warden.authenticate!(:password)
          end

          def logout
            env['rack.session.options'][:drop] = true
            warden.logout
          end

          def warden
            @warden ||= env['warden']
          end

          def current_user
            @current_user ||= warden.user
          end

          def set_session_value(key:, value:)
            warden.session(:user)[key.to_sym] = value
          end
        end
      end
    end
  end
end
