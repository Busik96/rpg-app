# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::SignIn, type: :request do
  subject(:request) { post url, params: params }

  let(:url) { "/api/v1/users/sign_in" }
  let!(:params) { {} }
  let!(:user) { create :user }

  context 'when params empty' do
    it 'returns 400' do
      request
      expect(response.code).to eq('400')
    end
  end

  context 'when params invalid' do
  let(:params) { { email: Faker::Internet.email, password: Faker::Internet.password } }
    it 'returns 422' do
      request
      expect(response.code).to eq('422')
      expect(json_response_body['status']).to eq('incorrect_credentials')
    end
  end

  context 'when it has params' do
    let(:params) { { email: user.email, password: user.password } }

    it 'returns 201' do
      request
      expect(response.code).to eq('201')
      expect(json_response_body['data']['token']).to eq(User.last.api_key)
    end
  end
end

