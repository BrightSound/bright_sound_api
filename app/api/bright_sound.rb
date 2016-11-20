require 'grape'
module BrightSound
  class API < Grape::API
    version 'v1', using: :header, vendor: 'bright_sound'
    format :json
    prefix :api

    resource :tests do
      # curl -X GET localhost:9292/api/tests/response
      desc 'Test Route'
      get :response do
        { this_is_a_test: 'hello everybody'}
      end
    end
  end
end
