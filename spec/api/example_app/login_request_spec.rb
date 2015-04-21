require 'rails_helper'

RSpec.describe 'Login request', type: :request do
  let!(:user) { create(:user, :with_token) }
  let!(:uri)  { '/api/v1/login' }

  describe 'User login' do
    let(:request) do
      post uri, request_params, mime_json
    end

    before(:each) { request }

    context 'happy path' do
      let(:request_params) { { user: { email: user.email, password: user.password } }.to_json }
      it { expect(response.status).to eq(201) }

      context 'request body data' do
        it { expect(parse_json(response.body)[:user][:authentication_token]).to_not be_nil }
        it { expect(parse_json(response.body)[:user][:email]).to eq(user.email) }
      end
    end

    context 'wrong email or password' do
      let(:request_params) { { user: { email: 'lolol', password: 'lmao' } }.to_json }
      it { expect(response.status).to eq(400) }
    end
  end
end
