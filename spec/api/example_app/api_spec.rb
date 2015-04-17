require 'rails_helper'

describe ExampleApp::API do
  describe "GET /api/v1" do
    before(:each) do
      get '/api/v1',
        { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    end
    it { expect(response.status).to eq(200) }
  end
end
