require 'grape'
Dir["#{File.expand_path('../../app/api/*.rb', __FILE__)}"].each {|f| require f}
