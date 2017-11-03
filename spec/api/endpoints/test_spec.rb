require 'spec_helper'

describe BrightSound::Endpoints::Test, type: :controller do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  let(:common_header_value) { { accept: "application/json" } }
  let(:response_body) { JSON.parse(last_response.body) }
  let!(:user) { create(:user) }

  describe 'Authorization' do
    context 'session provided' do
      context ' - authentic cookie' do
        let!(:user) { create(:user) }
        it 'should allow action if cookie present' do
          login_as user
          get '/api/tests/response'
          expect(last_response.status).to eq(200)
          expect(response_body['this_is_a_test']).to eq('hello everybody')
          expect(response_body['error']).not_to be
          # TODO: test current_user assignment
          # expect(assigns[:current_user]).to eq(1)
        end
      end

      context ' - forged cookie' do
        it 'should forbid action if cookie forged' do
          get '/api/tests/response'
          expect(last_response.status).to eq(401)
          expect(response_body['this_is_a_test']).not_to be
          expect(response_body['error']).to eq('Unauthorized')
        end
      end
    end

    context 'session not provided' do
      it 'should forbid action if rack.session cookie absent' do
        get '/api/tests/response'
        expect(last_response.status).to eq(401)
        expect(response_body['this_is_a_test']).not_to be
        expect(response_body['error']).to eq('Unauthorized')
      end
    end
  end

end
