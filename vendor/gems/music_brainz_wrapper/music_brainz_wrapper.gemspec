$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "music_brainz/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = 'music_brainz_wrapper'
  s.authors     = ['Dmitry Masukevich', 'Timofey Lavnik']
  s.email       = ['masukevich@gmail.com']
  s.summary     = 'Music Brainz API wrapper.'
  s.description = 'Search for artists.'

  s.files         = `git ls-files`.split($\)
  s.require_paths = ["lib"]
  s.version       = MusicBrainz::VERSION
  s.add_dependency "httparty", ">= 0.14.0"
end
