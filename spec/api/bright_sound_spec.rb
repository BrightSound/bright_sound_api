require 'spec_helper'

describe BrightSound::API do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  it 'should work' do
    get '/api/tests/response'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)['this_is_a_test']).to eq('hello everybody')
  end
end
