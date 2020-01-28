# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Inventory::UseItem, type: :request do
  subject(:request) { post url, headers: headers }

  let(:url) { "/api/v1/characters/#{character.id}/inventory/#{character_item.id}/use_item" }
  let!(:character_item) { create :character_item, character: character, item: item }
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
    let!(:valid_item_details) do
      {
        'name' => item.name,
        'description' => item.description,
        'stats' => item.stats,
        'reusable' => item.reusable
      }
    end

    it 'returns item details' do
      request
      expect(json_response_body['data']['attributes']).to eq(valid_item_details)
    end

    it 'returns code 201' do
      request
      expect(response.code).to eq('201')
    end
  end
end
