require 'rack-session-sequel'
module BrightSound
  class API < Grape::API
    use Rack::Session::Sequel, DB
  end
end

