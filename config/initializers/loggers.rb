require 'grape_logging'
module BrightSound
  class API < Grape::API
    unless ENV['RACK_ENV'] == 'test'
      logger.formatter = GrapeLogging::Formatters::Default.new
      use GrapeLogging::Middleware::RequestLogger,
          logger: logger,
          log_level: 'debug',
          include: [ GrapeLogging::Loggers::RequestHeaders.new,
                     GrapeLogging::Loggers::FilterParameters.new,
                     GrapeLogging::Loggers::ClientEnv.new,
                     GrapeLogging::Loggers::Response.new, ]
    end
  end
end
