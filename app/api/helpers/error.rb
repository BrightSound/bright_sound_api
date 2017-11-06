module BrightSound
  class API < Grape::API
    rescue_from Sequel::ValidationFailed do |e|
      error!(e, 422)
    end
  end
end
