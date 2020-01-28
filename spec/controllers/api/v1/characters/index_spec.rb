# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Inventory::Index, type: :request do
  subject(:request) { get url, headers: headers }

  let(:url) { '/api/v1/characters/' }
  let!(:character1) { create :character, user: user }
  let!(:character2) { create :character, user: user }
  let!(:user) { create :user }

  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end

  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }

    it 'returns two characters correctly' do
      request
      expect(json_response_body['data'].size).to eq(2)
    end

    let(:character1_details) do
    {
      'name' => character1.name,
      'description' => character1.description,
    }
    end

    it 'returns character1 details correctly' do
      request
      expect(json_response_body['data'].first['attributes']).to eq(character1_details)
    end

    it 'returns code 200' do
      request
      expect(response.code).to eq('200')
    end
  end
end
