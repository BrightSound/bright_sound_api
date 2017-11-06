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

          def warden
            @warden ||= env['warden']
          end

          def current_user
            @current_user ||= warden.user
          end
        end
      end
    end
  end
end
