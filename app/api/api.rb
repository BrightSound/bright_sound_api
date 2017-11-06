module BrightSound
  class API < Grape::API
    prefix 'api'
    format :json

    rescue_from Sequel::ValidationFailed do |e|
      error!(e, 422)
    end

    mount ::BrightSound::Endpoints::Authentication
    mount ::BrightSound::Endpoints::Test
  end
end
