require 'rack-session-sequel'
module BrightSound
  class API < Grape::API
    use Rack::Session::Sequel, db: DB, table_name: :sessions
  end
end

