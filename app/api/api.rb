module BrightSound
  class API < Grape::API
    prefix 'api'
    format :json

    mount ::BrightSound::Endpoints::Authentication
    mount ::BrightSound::Endpoints::Test
    mount ::BrightSound::Endpoints::Search
  end
end
