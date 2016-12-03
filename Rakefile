#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'dotenv/tasks'

require File.expand_path('../config/environment', __FILE__)
Dir.glob('lib/tasks/*.rake').each {|r| import r}

RSpec::Core::RakeTask.new

task default: :spec
task test: :spec
