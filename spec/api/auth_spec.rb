require 'spec_helper'

describe BrightSound::Base::Auth, type: :controller do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  let(:common_header_value) { { accept: "application/json" } }
  let(:response_body) { JSON.parse(last_response.body) }
  let!(:user) { create(:user) }

  describe 'Authorization' do
    context 'headers provided' do
      let(:authorization_header_value) { "Bearer #{jwt}" }

      before(:each) { header 'Authorization', authorization_header_value }

      context ' - authentic JWT' do
        let!(:user) { create(:user) }
        let(:jwt) { user.jwt }
        it 'should allow action if JWT present' do
          get '/api/tests/response', headers: common_header_value
          expect(last_response.status).to eq(200)
          expect(response_body['this_is_a_test']).to eq('hello everybody')
          expect(response_body['error']).not_to be
          # TODO: test current_user assignment
          # expect(assigns[:current_user]).to eq(1)
        end
      end

      context ' - forged JWT' do
        let(:jwt) { 'yJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.bHYPdXll1IcJdyqp91LLCPTYclBNWfDpoqgHkrziEa' }
        it 'should forbid action if JWT forged' do
          get '/api/tests/response', headers: common_header_value
          expect(last_response.status).to eq(401)
          expect(response_body['this_is_a_test']).not_to be
          expect(response_body['error']).to eq('Authentication error')
        end
      end
    end

    context 'headers not provided' do
      it 'should forbid action if JWT absent' do
        get '/api/tests/response', headers: common_header_value
        expect(last_response.status).to eq(401)
        expect(response_body['this_is_a_test']).not_to be
        expect(response_body['error']).to eq('Authentication error')
      end
    end
  end

end
