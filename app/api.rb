require 'grape_logging'
module BrightSound
  class API < Grape::API
    use Rack::Cors do
      allow do
        origins '*'

        resource '*',
                 headers: :any,
                 methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

    use Rack::Session::Sequel, DB

    Warden::Strategies.add(:password) do
      # def valid?
      #   params["email"] || params["password"]
      # end

      def authenticate!
        user =
          User.authenticate(params["email"], params["password"])
        if user
          success!(user)
        else
          # TODO: translate
          # throw :warden, auth: 'Email or password are invalid.'
          fail!('Email or password are invalid.')
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

    logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger,
        logger: logger,
        log_level: 'debug',
        include: [ GrapeLogging::Loggers::RequestHeaders.new,
                   GrapeLogging::Loggers::FilterParameters.new,
                   GrapeLogging::Loggers::ClientEnv.new,
                   GrapeLogging::Loggers::Response.new, ]

    prefix 'api'
    format :json
    mount ::BrightSound::Authentication
    mount ::BrightSound::Test
  end
end
