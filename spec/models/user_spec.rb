require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Active Record' do

    context 'validations' do
      it { is_expected.to have_secure_password }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end
  end

  describe '#generate_authentication_token' do
    let!(:user) { create(:user) }

    it 'creates an authentication token' do
      user.generate_authentication_token!
      expect(user.authentication_token).to_not be_nil
    end

    it 'should create new token each time' do
      user.generate_authentication_token!
      first_token = user.reload.authentication_token
      user.generate_authentication_token!
      second_token = user.reload.authentication_token

      expect(second_token == first_token).to eq(false)
    end
  end
end
