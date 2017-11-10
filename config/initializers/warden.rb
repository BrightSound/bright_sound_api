require 'warden'
module BrightSound
  class API < Grape::API
    Warden::Strategies.add(:password) do
      # def valid?
      #   params["email"] || params["password"]
      # end

      def authenticate!
        user =
          User.authenticate(params)
        if user
          success!(user)
        else
          # TODO: translate
          throw :warden, auth: 'Email or password are invalid.'
        end
      end
    end

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = lambda { |env| [422, {}, [env['warden.options'][:auth]]] }
    end

    Warden::Manager.serialize_into_session do |user|
      user.id
    end

    Warden::Manager.serialize_from_session do |id|
      User[id]
    end
  end
end

