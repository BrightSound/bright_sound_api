require 'dotenv'
Dotenv.load

require 'bcrypt'
require 'sequel'

ENV['DATABASE_URL']="sqlite://bs_#{ENV['RACK_ENV']}.sqlite3"
DB = Sequel.connect(ENV['DATABASE_URL'])

Dir["#{File.expand_path('../../app/models/mixins/*.rb', __FILE__)}"].each {|f| require f}
Dir["#{File.expand_path('../../app/models/*.rb', __FILE__)}"].each {|f| require f}

require 'grape'
require 'grape-entity'
require 'jwt'
require 'music_brainz/wrapper'

Dir["#{File.expand_path('../../app/api/entities/*.rb', __FILE__)}"].each {|f| require f}
Dir["#{File.expand_path('../../app/api/*.rb', __FILE__)}"].each {|f| require f}
Dir["#{File.expand_path('../../app/*.rb', __FILE__)}"].each {|f| require f}
Dir["#{File.expand_path('../../lib/*.rb', __FILE__)}"].each {|f| require f}

