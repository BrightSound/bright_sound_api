require 'spec_helper'

describe BrightSound::API do
  include Rack::Test::Methods

  def app
    BrightSound::API
  end

  it 'should work' do
    # header 'Authorization', 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoX3Rva2VuIjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SjFjMlZ5WDJsa0lqb3hmUS5iSFlQZFhsbDFJY0pkeXFwOTFMTENQVFljbEJOV2ZEcG9xZ0hrcnppRWFRIiwidXNlciI6eyJpZCI6MSwiZW1haWwiOiJtYXN1a2V2aWNoQGdtYWlsLmNvbSJ9fQ.ltTrogArGw9thuK07U_qWf3W8OAtwYxJp-jYjAJc8rA'
    header 'Authorization', 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.bHYPdXll1IcJdyqp91LLCPTYclBNWfDpoqgHkrziEaQ'
    get '/api/tests/response', headers: { accept: "application/json" }
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)['this_is_a_test']).to eq('hello everybody')
  end
end
