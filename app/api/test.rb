module BrightSound
  class Test < BrightSound::Base
    resource :tests do
      # curl -X GET localhost:9292/api/tests/response
      desc 'Test Route'
      get :response do
        authenticate!
        { this_is_a_test: 'hello everybody'}
      end
    end
  end
end
