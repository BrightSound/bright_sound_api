require_relative 'base'
module BrightSound
  module Endpoints
    class Test < Base
      resource :tests do

        before { authenticate! }

        # curl -X GET localhost:9292/api/tests/response
        get :response do
          # authenticate!
          { this_is_a_test: 'hello everybody'}
        end
      end
    end
  end
end
