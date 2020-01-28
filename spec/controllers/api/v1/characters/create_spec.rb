# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Create, type: :request do
  subject(:request) { post url, params: params, headers: headers }

  let(:url) { "/api/v1/characters" }
  let!(:params) { {} }
  let!(:user) { create :user }

  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end

  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }

    context 'when params empty' do
      it 'returns 400' do
        request
        expect(response.code).to eq('400')
        expect(json_response_body['error']).to eq('name is missing, description is missing')
      end
    end

    context 'when it has params' do
      let(:params) { { name: Faker::Name.name, description: Faker::Lorem.paragraph  } }

      it 'returns 201' do
        request
        expect(response.code).to eq('201')
        expect(json_response_body['data']['attributes']['name']).to eq(Character.last.name)
      end

      it 'change characters count' do
        expect { request }.to change(Character, :count).by(1)
      end
    end
  end
end
