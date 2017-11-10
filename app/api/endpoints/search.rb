require_relative 'base'
module BrightSound
  module Endpoints
    class Search < Base
      resource :search do

        # before { authenticate! }

        # curl -X GET localhost:9292/api/search/music_brainz
        params do
          requires :query, type: String, desc: 'Search query'
        end

        get :music_brainz do
          MusicBrainz::Wrapper.search_artist(params[:query])
        end
      end
    end
  end
end
