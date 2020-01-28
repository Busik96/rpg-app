# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Characters::Inventory::UseItem, type: :request do
  subject(:request) { post url, params: params, headers: headers }

  let(:url) { "/api/v1/characters/#{character.id}/inventory/add_item" }
  let(:character) { create :character, user: user }
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

    context 'when amount > 10' do
      let!(:params) { { amount: 14, item_id: item.id } }

      it 'returns two stacks' do
        expect { request }.to change(CharacterItem, :count).by(2)
      end

      it 'returns code 201' do
        request
        expect(response.code).to eq('201')
      end
    end

    context 'when amount < 10' do
      let!(:params) { { amount: 4, item_id: item.id } }

      it 'returns one stack with amount = 4' do
        expect { request }.to change(CharacterItem, :count).by(1)
        expect(CharacterItem.last.amount).to eq(4)
      end

      it 'returns code 201' do
        request
        expect(response.code).to eq('201')
      end
    end

    context 'when has inventory_item error' do
      let(:dummy_service) { instance_double('AddItem') }
      let(:error_result) { instance_double('Result', error: 'error', amount_left: 5) }
      let!(:params) { { amount: 4, item_id: item.id } }

      before do
        allow(Inventory::AddItem).to receive(:new).and_return(dummy_service)
        allow(dummy_service).to receive(:call).and_return(error_result)
      end

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
