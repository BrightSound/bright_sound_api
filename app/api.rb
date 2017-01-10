module BrightSound
  class API < Grape::API
    prefix 'api'
    format :json
    mount ::BrightSound::Authentication
    mount ::BrightSound::Test
  end
end
