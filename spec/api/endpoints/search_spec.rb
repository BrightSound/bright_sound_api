require 'spec_helper'

describe BrightSound::Endpoints::Search, type: :controller do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  describe 'Search' do
    let(:response_status) { last_response.status }
    let(:response_body) { JSON.parse(last_response.body) }

    describe '#music_brainz' do
      let(:search_music_brainz) { get '/api/search/music_brainz', query_params }

      before(:each) do
        search_music_brainz
      end

      context 'query provided' do
        let(:query_params) { { query: 'Nirvana'} }

        it '' do
          expect(response_body['error']).not_to be
          expect(response_status).to eq(200)

        end
      end

      context 'query absent' do
        let(:query_params) { Hash.new }
        it '' do
          expect(response_body['error']).to eq ('query is missing')
          expect(response_status).to eq(400)

        end
      end
    end
  end
end
