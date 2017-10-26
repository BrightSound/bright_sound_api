require 'spec_helper'

describe BrightSound::Authentication, type: :controller do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(8, 20, true) }
  let(:user_params) { { email: email, password: password } }
  let(:response_body) { JSON.parse(last_response.body) }
  let(:response_headers) { last_response.headers }

  describe '#sign_up' do
    let(:sign_up) do
      post '/api/authentication/sign_up', user_params
    end
    let(:user) { User.first }

    it 'should change user count on success' do
      expect{ sign_up }.to change{ User.count }.from(0).to(1)
    end

    it 'on success returns proper code and response' do
      sign_up
      expect(last_response.status).to eq(201)
      expect(response_body['email']).to eq(email)
      expect(response_body['error']).not_to be
    end
  end

  describe '#login' do
    let!(:user) { create(:user, user_params) }
    let(:login) { post '/api/authentication/login', user_params }
    let(:session_cookie_content) { response_headers['Set-Cookie'] }
    let(:sid_from_cookie) { /rack.session=(\w+);/.match(session_cookie_content)[1] }
    let(:session_from_db) { Session.where(sid: sid_from_cookie).first }
    it 'on success returns proper code and response' do
      login
      expect(last_response.status).to eq(201)
      expect(response_body['email']).to eq(email)
      expect(response_body['error']).not_to be
      expect(Session.all.count).to eq(1)
      expect(session_from_db).to be
    end
  end
end
