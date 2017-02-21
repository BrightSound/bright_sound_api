require 'rubygems'
require 'httparty'
require 'json'
require 'uri'

module MusicBrainz
  class Wrapper
    include HTTParty
    base_uri 'http://musicbrainz.org/ws/2/artist/'
    headers  'Content-Type' => 'application/xmls'
    headers  'User-Agent' => 'BrightSound/0.0'
    format :xml

    class << self
      # http://musicbrainz.org/ws/2/artist/?query=artist:bohren
      def search_artist(artist_name)
        query = { query: "artist:#{artist_name}" }
        get('/', query: query)
      end

      # http://musicbrainz.org/ws/2/artist/938df0a0-c650-4cf8-9b23-5ad8a5cb4805?inc=url-rels
      def artist_details(artist_id)
        query = { inc: 'url-rels' }
        get("/#{artist_id}", query: query)
      end
    end
  end
end
