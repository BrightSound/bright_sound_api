require 'dotenv'
Dotenv.load

require 'pry'
require 'bcrypt'
require 'sequel'
require 'grape'
require 'grape-entity'
require 'music_brainz/wrapper'

INITIALIZERS =
  %w(
    ../initializers/*.rb
  )
MODELS =
  %w(
    ../../app/models/mixins/*.rb
    ../../app/models/*.rb
  )
API =
  %w(
    ../../app/api/entities/*.rb
    ../../app/api/endpoints/*.rb
    ../../app/api/*.rb
  )
LIB =
  %w(
    ../../lib/*.rb
  )

REQUIRE_ORDER = INITIALIZERS + MODELS + API + LIB

REQUIRE_ORDER.each do |relative_path|
  Dir["#{File.expand_path(relative_path, __FILE__)}"].each {|f| require f}
end

