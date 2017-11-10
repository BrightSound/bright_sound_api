require 'rack/cors'
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
  end
end
