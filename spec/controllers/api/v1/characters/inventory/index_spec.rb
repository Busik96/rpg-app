# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Inventory::Index, type: :request do
  subject(:request) { get url, headers: headers }

  let(:url) { "/api/v1/characters/#{character.id}/inventory" }
  let!(:character_item1) { create :character_item, character: character, item: item }
  let!(:character_item2) { create :character_item, character: character, item: item }
  let(:character) { create :character, user: user }
  let(:item) { create :item }
  let!(:user) { create :user }

  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end


  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }

    it 'returns two character items correctly' do
      request
      expect(json_response_body['data'].size).to eq(2)
    end

    let(:item_details) do
    {
      'name' => item.name,
      'description' => item.description,
      'stats' => item.stats,
      'reusable' => item.reusable
    }
    end

    it 'returns included item details correctly' do
      request
      expect(json_response_body['included'].first['attributes']).to eq(item_details)
    end

    it 'returns code 200' do
      request
      expect(response.code).to eq('200')
    end
  end
end
