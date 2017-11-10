source 'https://rubygems.org'

gem 'bundler', '1.13.6'
gem 'grape', '0.19.0'
gem 'grape-entity', '0.6.0'
gem 'json', '2.0.2'
gem 'sequel', '4.41.0' # ORM
gem 'sequel-seed', '1.0.0'
gem 'jwt', '1.5.6' # used for authentication token
gem 'bcrypt', '3.1.11' # used for storing passwords
gem 'rack-cors' # allowing cross-origin resource sharing, for NG2
gem 'grape_logging', '1.7.0'
gem 'rack-session-sequel', '0.0.1'
gem 'warden', '1.2.7'
gem 'pry-byebug', '3.5.0'

gem 'music_brainz_wrapper', path: 'vendor/gems/music_brainz_wrapper'

group :development, :test do
  gem 'rake', '12.0.0'
  gem 'sqlite3', '1.3.12'
  gem 'dotenv', '2.1.1'
end

group :development do
  gem 'guard', '2.14.1'
  gem 'guard-bundler', '2.1.0', require: false
  gem 'guard-rack', '2.2.0'
end

group :development, :production do
  gem 'grape-cli', '0.2.5'
end

group :test do
  gem 'rack', '2.0.1' # Travis Ci needs it here
  gem 'rack-test', '0.6.3'
  gem 'rspec', '3.5.0'
  gem 'database_cleaner', '1.5.3'
  gem 'factory_girl', '4.8.0'
  gem 'faker', '1.7.2' # used to stub realistic data in specs
  gem 'rspec_sequel_matchers', '0.4.0'
end
