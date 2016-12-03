require 'dotenv'
Dotenv.load

require 'sequel'
DB = Sequel.connect(ENV['DATABASE_URL'])
Dir["#{File.expand_path('../../app/models/*.rb', __FILE__)}"].each {|f| require f}

require 'grape'
require 'jwt'

Dir["#{File.expand_path('../../app/api/*.rb', __FILE__)}"].each {|f| require f}
Dir["#{File.expand_path('../../lib/*.rb', __FILE__)}"].each {|f| require f}

