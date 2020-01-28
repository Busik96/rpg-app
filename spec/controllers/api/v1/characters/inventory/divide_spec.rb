# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Inventory::Divide, type: :request do
  subject(:request) { post url, params: params, headers: headers }

  let(:url) { "/api/v1/characters/#{character.id}/inventory/#{character_item.id}/divide" }
  let(:character) { create :character, user: user }
  let!(:character_item) { create :character_item, character: character, item: item, amount: 5 }
  let!(:user) { create :user }
  let(:item) { create :item}
  let(:params) { {} }

  describe 'without sign in user' do
    it 'returns 401 Unauthorized' do
      request
      expect(response.body).to include('401')
    end
  end

  describe 'with sign in user' do
    let(:headers) { { 'Authorization' => user.api_key } }

    context 'when params empty' do
      it 'returns error' do
        request
        expect(response.code).to eq('400')
      end
    end

    context 'when divide possible' do
      let!(:params) { { desired_amount: 3 } }

      it 'returns current stack amount correctly' do
        request
        expect(character_item.reload.amount).to eq(2)
      end

      it 'returns new stack with 3 items' do
        expect { request }.to change(CharacterItem, :count).by(1)
        expect(CharacterItem.last.amount).to eq(3)
      end

      it 'returns code 201' do
        request
        expect(response.code).to eq('201')
      end
    end


    context 'when divide impossible' do
      let!(:params) { { desired_amount: 5 } }

      it 'returns code 422' do
        request
        expect(response.code).to eq('422')
      end

      it 'returns error message' do
        request
        expect(response.body['error']).to eq('error')
      end
    end
  end
end
