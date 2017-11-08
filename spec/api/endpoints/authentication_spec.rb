require 'spec_helper'

describe BrightSound::Endpoints::Authentication, type: :controller do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(8, 20, true) }
  let(:user_params) { { email: email, password: password } }
  let(:response_body) { JSON.parse(last_response.body) }
  let(:response_headers) { last_response.headers }

  let(:session_cookie_content) { response_headers['Set-Cookie'] }
  let(:sid_from_header) { /rack.session=(\w+);/.match(session_cookie_content)[1] }
  let(:session_from_db) { Session.where(sid: sid_from_header).first }

  let(:sid_from_cookies) { last_request.cookies['rack.session'] }
  let(:sid_from_mock_session) { rack_mock_session.cookie_jar['rack.session'] }

  describe '#sign_up' do
    let(:sign_up) do
      post '/api/authentication/sign_up', user_params
    end
    let(:user_from_db) { User.first }

    context 'on success' do
      it 'should change user count' do
        expect{ sign_up }.to change{ User.count }.from(0).to(1)
      end

      it 'should change sessions count' do
        expect{ sign_up }.to change{ Session.count }.from(0).to(1)
      end

      it 'returns proper code and response' do
        sign_up
        expect(user_from_db.email).to eq(email)
        expect(last_response.status).to eq(201)
        expect(response_body['email']).to eq(email)
        expect(response_body['error']).not_to be
      end
    end

    context 'on failure' do
      let!(:user) { create(:user, user_params) }

      it 'should not change user count' do
        expect{ sign_up }.not_to change{ User.count }
      end

      it 'should change sessions count' do
        expect{ sign_up }.not_to change{ Session.count }
      end

      it 'returns proper code and response' do
        sign_up
        expect(last_response.status).to eq(422)
        expect(response_body['error']).to eq('email is already taken')
      end
    end
  end

  describe '#login' do
    let!(:user) { create(:user, user_params) }
    let(:login) { post '/api/authentication/login', user_params }

    context 'on success' do
      it 'returns proper code and response' do
        login
        expect(last_response.status).to eq(201)
        expect(sid_from_header).to be
        expect(response_body['email']).to eq(email)
        expect(response_body['error']).not_to be
        expect(Session.all.count).to eq(1)
        expect(session_from_db).to be
      end
    end

    context 'on failure' do
      it 'returns proper code and response'
    end
  end

  describe '#logout' do
    let!(:user) { create(:user, user_params) }
    let(:login) { post '/api/authentication/login', user_params }
    let(:logout) { post '/api/authentication/logout' }

    before(:each) do
      login
    end

    context 'on success' do
      it 'should change user count' do
        expect{ logout }.to change{ Session.count }.from(1).to(0)
      end

      it 'returns proper code and response'
    end

    context 'on failure' do
      it 'returns proper code and response'
    end
  end
end
