module BrightSound
  class Test < BrightSound::Base
    resource :tests do

      before do
        # error("Unauthorized", 401) unless current_user
        # raise current_user.inspect
      end

      # curl -X GET localhost:9292/api/tests/response
      get :response do
        # authenticate!
        { this_is_a_test: 'hello everybody'}
      end
    end
  end
end
