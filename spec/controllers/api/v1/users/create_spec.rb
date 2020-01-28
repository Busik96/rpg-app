#frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Create, type: :request do
  subject(:request) { post url, params: params}

  let(:url) { "/api/v1/users" }
  let!(:params) { {} }

  context 'when params empty' do
    it 'returns 400' do
      request
      expect(response.code).to eq('400')
      expect(json_response_body['error']).to eq('email is missing, password is missing')
    end
  end

  context 'when it has params' do
    let!(:params) { { email: Faker::Internet.email, password: 'password' } }

    it 'returns 201' do
      request
      expect(response.code).to eq('201')
      expect(json_response_body['data']['attributes']['email']).to eq(User.last.email)
    end

    it 'change users count' do
      expect { request }.to change(User, :count).by(1)
    end
  end
end
