require File.expand_path('../config/environment', __FILE__)

use Rack::Cors do
  allow do
    origins '*'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end

run BrightSound::API
